class nova-db::install {
  # we only have to install if there isn't a nova db

  if ($ha_primary) or (!$use_ha) {
    exec { "create_nova_db":
      command     => "mysql -uroot -p${mysql_root_password} -e 'create database nova'",
      path        => [ "/bin", "/usr/bin" ],
      unless      => "mysql -uroot -p${mysql_root_password} -sr -e 'show databases' | grep -q nova",
      notify      => Exec["create_nova_user"],
      # this *should* be already done with the require mysql::server, but apparently isn't
      require     => [Service['mysql'], Class['mysql::server']]
    }
  }

  exec { "create_nova_user":
    # FIXME:
    # someone really need to get db access limited to just
    # the controller nodes
    command     => "mysql -uroot -p${mysql_root_password} -e \"grant all on nova.* to 'nova'@'%' identified by '${mysql_nova_password}'\"",
    path        => [ "/bin", "/usr/bin" ],
    notify      => Exec["sync_nova_db"],
    require     => Service['mysql'],
    refreshonly => true
  }

  # this is all totally brute force
  exec { "sync_nova_db":
    command     => "sudo -u nova nova-manage db sync",
    path        => [ "/bin", "/usr/bin" ],
    refreshonly => true,
    notify      => Exec["create_admin_user"],
    require     => [File["/etc/nova/nova.conf"], Package['nova-common']]
  }

  # FIXME(ja): we shouldn't need this - since users are created in keystone
  exec { "create_admin_user":
    command     => "sudo -u nova nova-manage user admin ${nova_admin_user} ${nova_admin_password}",
    path        => [ "/bin", "/usr/bin" ],
    refreshonly => true,
    notify      => Exec["create_initial_network"]
  }

  exec { "create_initial_network":
    command     => "sudo -u nova nova-manage network create private ${fixed_range} ${num_networks} ${network_size} T",
    path        => [ "/bin", "/usr/bin" ],
    refreshonly => true
  }

  # FIXME(ja): hack to add a custom firewall set
  file { "secgroup.sql":
    path => "/var/lib/nova/secgroup.sql",
    require => Package['nova-common'],
    source => "puppet:///modules/nova-db/secgroup.sql",
    # notify => Exec["create_default_secgroup"]
  }

  # exec { "create_default_secgroup":
  #   command     => "mysql nova -uroot -p${mysql_root_password} < /var/lib/nova/secgroup.sql",
  #   path        => [ "/bin", "/usr/bin" ],
  #   refreshonly => true,
  #   require     => File['secgroup.sql']
  # }
}

