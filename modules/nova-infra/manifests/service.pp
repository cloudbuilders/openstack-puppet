class nova-infra::service {
  $nova_infra_services = [ "nova-api", "nova-objectstore", "nova-scheduler" ]

  service { $nova_infra_services:
    ensure    => running,
    enable    => true,
    require   => File["nova-default"],
    subscribe => File["/etc/nova/nova.conf"]
  }
  
  file { "nova-default":
    path => "/etc/default/nova-common",
    content => "ENABLED=1"
  }
}
