class nova-compute::service {
  service { "nova-compute":
    ensure    => running,
    enable    => true,
    subscribe => File["/etc/nova/nova.conf"],
    require   => Class["nova-compute::install"]
  }

  service { "nova-network":
    ensure    => running,
    enable    => true,
    subscribe => File["/etc/nova/nova.conf"],
    require   => Class["nova-compute::install"]
  }
}
