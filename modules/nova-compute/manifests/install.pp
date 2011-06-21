class nova-compute::install {
  require "nova-common"
  
  $nova_compute_packages = [ "nova-compute", "nova-network" ]

  package { $nova_compute_packages:
    ensure => latest
  }
}
