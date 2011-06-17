class glance::service {
  $glance_services = [ "glance-api", "glance-registry" ]
  service { $glance_services:
    ensure  => running,
    enable  => true,
    require => Class["glance::install"]
  }
}
