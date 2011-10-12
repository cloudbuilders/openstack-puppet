class haproxy::install {
  package { "haproxy":
    ensure => present
  }
}
