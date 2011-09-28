class infra-patches::install {

  file { "/usr/share/pyshared/django_openstack/api.py":
    source  => "puppet:///modules/infra-patches/api.py",
    backup  => true,
    require => Package["openstack-dashboard"],
    notify  => Service["apache2"]
  }

}

