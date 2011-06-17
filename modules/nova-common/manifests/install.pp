class nova-common::install {
  $nova_common_packages = [ "nova-common", "nova-doc", "python-nova" ]
  $nova_common_misc     = [ "euca2ools", "unzip" ]
  
  package { $nova_common_packages:
    ensure => latest
  }

  package { $nova_common_misc:
    ensure => present
  }
}
