class nova-network::service {

  service { "nova-network":
    ensure    => running,
    enable    => true,
    require   => File["nova-default"],
    subscribe => File["/etc/nova/nova.conf"]
  }
  
}
