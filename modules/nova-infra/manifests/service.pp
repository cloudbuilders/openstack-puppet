class nova-infra::service {
  $nova_infra_services = [ "nova-api", "nova-objectstore", "nova-scheduler" ]

  service { $nova_infra_services:
    ensure    => running,
    enable    => true,
    subscribe => File["/etc/nova/nova.conf"]
  }
}
