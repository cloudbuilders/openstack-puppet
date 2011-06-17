class ntp::install {
  package { "ntp":
    ensure => present
  }
}
