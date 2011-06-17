class nova-compute::service {
  service { "nova-compute":
    ensure    => running,
    enable    => true,
    subscribe => File["/etc/nova/nova.conf"]
  }

  service { "nova-network":
    ensure    => running,
    enable    => true,
    subscribe => File["/etc/nova/nova.conf"]
  }
}
