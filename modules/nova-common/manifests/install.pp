class nova-common::install {
  $nova_common_packages = [ "nova-common", "nova-doc", "python-nova" ]
  $nova_common_misc     = [ "euca2ools", "unzip" ]

  apt::ppa { "ppa:nova-core/trunk": }

  package { $nova_common_packages:
    ensure  => latest,
    require => Apt::Ppa["ppa:nova-core/trunk"]
  }

  package { $nova_common_misc:
    ensure  => present,
    require => Apt::Ppa["ppa:nova-core/trunk"]    
  }
}
