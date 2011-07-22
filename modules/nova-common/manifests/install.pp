class nova-common::install {
  $nova_common_packages = [ "nova-common", "nova-doc", "python-nova", "python-eventlet", "python-mysqldb" ]

  package { $nova_common_packages:
    ensure  => latest,
    require => Class["rcb-common"]
  }
  
  file { "nova-default":
    path => "/etc/default/nova-common",
    content => "ENABLED=1",
    require => Package["nova-common"]
  }
}
