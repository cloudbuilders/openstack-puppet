class nova-common::install {
  $nova_common_packages = [ "nova-common", "nova-doc", "python-nova", "python-mysqldb", "python-eventlet", "python-novaclient" ]

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
