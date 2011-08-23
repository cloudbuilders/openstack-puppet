class omsa::install {

  package { "":
    ensure => present,
    notify => Class["omsa::service"],
  }
}
