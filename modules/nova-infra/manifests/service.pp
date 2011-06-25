class nova-infra::service {
  $nova_infra_services = [ "nova-scheduler", "nova-network" ]

  service { $nova_infra_services:
    ensure    => running,
    enable    => true,
    require   => File["nova-default"],
    subscribe => File["/etc/nova/nova.conf"]
  }
  
}
