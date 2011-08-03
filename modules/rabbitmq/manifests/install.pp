class rabbitmq::install {
  group { 'rabbitmq':
    ensure  => present,
    gid     => 502
  }

  user { 'rabbitmq':
    ensure  => present,
    uid     => 502,
    gid     => 'rabbitmq',
    home    => '/var/lib/rabbitmq',
    shell   => '/bin/false',
    require => Group['rabbitmq']
  }
    
  package { "rabbitmq-server":
    ensure  => present,
    require => User['rabbitmq']
  }
}
