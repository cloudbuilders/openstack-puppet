class rabbitmq::service {
  service { "rabbitmq-server":
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Class['rabbitmq::install']
  }
}
