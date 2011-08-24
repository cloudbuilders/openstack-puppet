class omsa::install {

  package { "srvadmin-all":
    ensure => present,
    require => Class["omsa::config"],
    notify => Class["omsa::service"]
  }
}
