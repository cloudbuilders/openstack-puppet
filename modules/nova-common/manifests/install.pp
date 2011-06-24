class nova-common::install {
  $nova_common_packages = [ "nova-common", "nova-doc", "python-nova", "python-eventlet" ]

  # FIXME(ja): move this to rcb common, then glance, keystone, ... don't need to require nova common
  apt::source { "rcb":
    location => "http://devpackages.ansolabs.com",
    release => "maverick",
    repos => "main",
    key => "460DF9BE",
    key_server => "keyserver.ubuntu.com",
    pin => "-1"
  }

  package { $nova_common_packages:
    ensure  => latest,
    require => Apt::Source["rcb"]
  }
  
  file { "nova-default":
    path => "/etc/default/nova-common",
    content => "ENABLED=1",
    require => Package["nova-common"]
  }

}
