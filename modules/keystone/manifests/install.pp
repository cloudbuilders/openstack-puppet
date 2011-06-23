class keystone::install {

  package { "keystone":
    ensure => present
  }
  
  file { "initial_data.sh":
    path => "/var/lib/keystone/initial_data.sh",
    ensure  => present,
    owner   => "keystone",
    mode    => 0700,
    source  => "puppet:///modules/keystone/initial_data.sh",
    require => Package["keystone"]
  }

  exec { "create_keystone_data":
    user => "keystone",
    command     => "/var/lib/keystone/initial_data.sh",
    path        => [ "/bin", "/usr/bin" ],
    unless      => "keystone-manage user list | grep -q admin",
    require     => [
      Package['keystone'],
      File["initial_data.sh"]
    ]
  }

}
  
