class mysql::service {
  service { "mysql":
    ensure => running,
    enable => true,
    require => Class["mysql::config"]
  }
}
