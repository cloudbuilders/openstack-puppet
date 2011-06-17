class rabbitmq::install {
  package { "rabbitmq-server":
    ensure => present
  }
}
