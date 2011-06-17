class nova-common::install {
  $nova_common_packages = [ "nova-common", "nova-doc", "python-nova",
                            "euca2ools", "unzip" ]
  
  package { $nova_common_packages:
    ensure => present
  }
}
