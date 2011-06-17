class nova-compute::install {
  $nova_compute_packages = [ "nova-compute", "nova-network" ]

  package { $nova_compute_packages:
    ensure => present
  }
}
