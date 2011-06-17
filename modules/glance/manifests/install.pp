class glance::install {
  $glance_packages = [ "glance", "python-glance" ]

  package { $glance_packages:
    ensure => present
  }
}
  
