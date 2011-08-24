class omsa::service {

  service { "dataeng":
    ensure => running,
    enable => true,
    require => Class["omsa::install"]
  }

  service { "dsm_om_connsvc":
    ensure => running,
    enable => true,
    require => Class["omsa::install"]
  }
}
