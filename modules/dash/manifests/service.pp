class dash::service {
  service { "apache2":
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Class["dash::install"]
  }
}
