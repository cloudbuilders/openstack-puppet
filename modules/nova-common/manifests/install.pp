class nova-common::install {
  $nova_common_packages = [ "nova-common", "nova-doc", "python-nova", "python-eventlet" ]
  $nova_common_misc     = [ "euca2ools", "unzip" ]

  apt::source { "rcb":
    location => "http://devpackages.ansolabs.com",
    release => "maverick",
    repos => "main",
    key => "460DF9BE",
    key_server => "keyserver.ubuntu.com",
    pin => "600"
  }

  package { $nova_common_packages:
    ensure  => latest,
    require => Apt::Source["rcb"]
  }

  package { $nova_common_misc:
    ensure  => present,
    require => Apt::Source["rcb"]
  }
}
