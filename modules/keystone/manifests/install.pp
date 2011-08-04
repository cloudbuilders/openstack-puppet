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
  
