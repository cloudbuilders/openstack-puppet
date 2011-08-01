class rabbitmq::config {
  file { "/etc/rabbitmq/rabbitmq-env.conf":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0644,
    content => template('rabbitmq/rabbitmq-env.conf.erb'),
    notify  => Service['rabbitmq-server'],
    require => Class['rabbitmq::install']
  }
}
  
