class nova-reserve-ip::install {

  package { "mysql":
    ensure  => latest,
  }

  exec { "reserve_ip":
    command     => "mysql #",
    path        => [ "/bin", "/usr/bin" ],
    not_if      => "mysql #",
  }
}

