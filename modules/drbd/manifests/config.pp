class drbd::config {
  require 'drbd::install'
  notice "ip addr add $ha_vip dev eth0"
  notice "ha_primary: $ha_primary"
  
  file { '/etc/drbd.d/infra.res':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('drbd/infra.res.erb')
  }

  exec { 'drbd-load-module':
    command => 'modprobe drbd',
    path    => '/usr/bin:/usr/sbin:/bin:/sbin',
    onlyif  => 'test ! -e /proc/drbd'
  }

  file { '/etc/apparmor.d/local/usr.sbin.mysqld':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0600',
    source  => 'puppet:///modules/drbd/usr.sbin.mysqld',
    notify  => Exec['reload-apparmor-profiles']
  }

  exec { 'reload-apparmor-profiles':
    command     => 'service apparmor reload',
    path        => '/usr/bin:/usr/sbin:/bin:/sbin',
    refreshonly => true
  }

  file { "/drbd":
    ensure => directory,
    mode   => 0755,
    owner  => "root",
    group  => "root"
  }
    
  # if I'm diskless, it's because my md hasn't been set up.
  exec { 'drbd-create':
    command => 'echo "yes" | drbdadm create-md infra0',
    path    => '/usr/bin:/usr/sbin:/bin:/sbin',
    onlyif  => "/bin/bash -c 'drbdadm status | grep infra0 | grep -q ds1=.Diskless.'",
    notify  => Service['drbd'],
    require => [ Exec['drbd-load-module'], File['/etc/drbd.d/infra.res'] ]
  }

  if $ha_primary and $ha_initial_setup {
    # we'll only do these actions if we're in a secondary/secondary state and we are
    # still in setup mode
    exec { 'drbd-make-primary':
      command     => 'drbdadm -- --overwrite-data-of-peer primary infra0',
      path        => '/usr/bin:/usr/sbin:/bin:/sbin',
      notify      => Exec['drbd-format-volume'],
      onlyif      => "/bin/bash -c 'drbdadm status | grep ro1=.Secondary. | grep -q ro2=.Secondary.'",
    }      

    exec { 'drbd-format-volume':
      command     => 'mke2fs -j /dev/drbd0',
      path        => '/usr/bin:/usr/sbin:/bin:/sbin',
      refreshonly => true,
      require     => File['/usr/local/bin/drbd-migrate-data.sh']
    }

    file { '/usr/local/bin/drbd-migrate-data.sh':
      ensure      => present,
      owner       => 'root',
      group       => 'root',
      mode        => 0755,
      refreshonly => true,
      source      => 'puppet:///modules/drbd/drbd-migrate-data.sh'
    }
  }

  if $ha_primary {
    # mount the drive
    mount { "/drbd":
      atboot  => true,
      device  => "/dev/drbd0",
      ensure  => mounted,
      fstype  => "auto",
      options => "defaults",
      notify  => Exec['drbd-migrate-data'],
      require => File["/drbd"]
    }

    exec { 'drbd-migrate-data':
      command     => '/usr/local/bin/drbd-migrate-data.sh',
      path        => '/usr/bin:/usr/sbin:/bin:/sbin',
      refreshonly => true
    }

    # turn up the VIP -- this probably doesn't go here
    exec { 'drbd-add-ha-vip':
      command    => "ip addr add $ha_vip dev eth0",
      path       => '/usr/bin:/usr/sbin:/bin:/sbin',
      unless     => "/bin/bash -c 'ip addr show eth0 | grep -q $ha_vip'"
    }
  } else {
    mount { "/drbd":
      atboot => false,
      ensure => absent
    }

    exec { 'drbd-remove-ha-vip':
      command => "ip addr remove ${ha_vip}/32 dev eth0",
      path    => '/usr/bin:/usr/sbin:/bin:/sbin',
      onlyif  => "/bin/bash -c 'ip addr show eth0 | grep -q $ha_vip'"
    }
  }
}
