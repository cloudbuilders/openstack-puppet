class nova-infra::install {
  # not all of these are probably requires on an infra box
  $nova_infra_packages = [ "nova-api", "nova-objectstore", "nova-scheduler" ]

  package { $nova_infra_packages:
    ensure => present
  }
}
  
