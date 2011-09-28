class infra-patches::install {

  file { "/usr/share/pyshared/django_openstack/api.py":
    source  => "puppet:///modules/infra-patches/api.py",
    backup  => true,
    require => Package["dash"],
    notify  => Service["apache2"]
  }

}

