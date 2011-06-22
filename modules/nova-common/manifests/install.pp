class nova-common::install {
  $nova_common_packages = [ "nova-common", "nova-doc", "python-nova", "python-eventlet" ]
  $nova_common_misc     = [ "euca2ools", "unzip" ]

  apt::key { "460DF9BE":
    ensure => present,
  }

  apt::sources_list {"rcb":
    ensure => present
    content => "deb http://devpackages.ansolabs.com maverick main",
    require => apt::key["460DF9BE"]
  }

  package { $nova_common_packages:
    ensure  => latest,
    require => apt::sources_list["rcb"]
  }

  package { $nova_common_misc:
    ensure  => present,
    require => apt::sources_list["rcb"]
  }
}
