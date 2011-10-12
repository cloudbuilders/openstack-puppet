class keystone::install {

  # ha configs require a synced uid
  user { "keystone":
    ensure  => present,
    uid     => 505,
    gid     => 65534,
    home    => "/var/lib/keystone",
    shell   => "/bin/bash"
  }
    
  package { "keystone":
    ensure => latest,
    notify => [Service["apache2"], Service["nova-api"]],
    require => [
      Apt::Source["rcb"],
      Package["nova-common"],
      User["keystone"]
    ]
  }

  file { "keystone.conf":
    path => "/etc/keystone/keystone.conf",
    ensure  => present,
    owner   => "keystone",
    mode    => 0600,
    content => template("keystone/keystone.conf.erb"),
    notify => Service["keystone"],
    require => Package["keystone"]
  }
  
  file { "initial_data.sh":
    path => "/var/lib/keystone/initial_data.sh",
    ensure  => present,
    owner   => "keystone",
    mode    => 0700,
    content => template("keystone/initial_data.sh.erb"),
    require => Package["keystone"]
  }


  if ($ha_primary) or (!$use_ha) {
    exec { "create_keystone_db":
      command     => "mysql -uroot -p${mysql_root_password} -e 'create database keystone'",
      path        => [ "/bin", "/usr/bin" ],
      unless      => "mysql -uroot -p${mysql_root_password} -sr -e 'show databases' | grep -q keystone",
      notify      => Exec["create_keystone_user"],
      # this *should* be already done with the require mysql::server, but apparently isn't
      require     => [Service['mysql'], Class['mysql::server']]
    }
  }

  exec { "create_keystone_user":
    # FIXME:
    # someone really need to get db access limited to just
    # the controller nodes
    command     => "mysql -uroot -p${mysql_root_password} -e \"grant all on keystone.* to 'keystone'@'%' identified by '${mysql_nova_password}'\"",
    path        => [ "/bin", "/usr/bin" ],
    notify      => Exec["sync_keystone_db"],
    require     => Service['mysql'],
    refreshonly => true
  }

  # this is all totally brute force
  exec { "sync_keystone_db":
    command     => "sudo -u keystone keystone-manage db_sync",
    path        => [ "/bin", "/usr/bin" ],
    notify      => Exec["create_keystone_data"],
    refreshonly => true,
    require     => [File["/etc/keystone/keystone.conf"], Package['keystone']]
  }

  exec { "create_keystone_data":
    user => "keystone",
    command     => "/var/lib/keystone/initial_data.sh",
    path        => [ "/bin", "/usr/bin" ],
    unless      => "keystone-manage user list | grep -q admin",
    require     => [
      Package['keystone'],
      File['keystone.conf'],
      File["initial_data.sh"]
    ]
  }

}
  
