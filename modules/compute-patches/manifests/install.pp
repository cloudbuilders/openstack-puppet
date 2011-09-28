class compute-patches::install {

  file { "/usr/share/pyshared/nova/image/glance.py":
    source  => "puppet:///modules/compute-patches/glance.py",
    backup  => true,
    require => Package["nova-compute"],
    notify  => Service["nova-compute"]
  }

}

