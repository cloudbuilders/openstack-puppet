class ssh::service {
  service { "ssh":
    ensure  => running,
    enable  => true,
    require => Class["ssh::config"]
  }
}

