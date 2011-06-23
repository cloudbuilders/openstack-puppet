class keystone::service {

  service { "keystone":
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Class["keystone::install"]
  }
}
