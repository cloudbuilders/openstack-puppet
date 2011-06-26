class nova-scheduler::service {

  service { "nova-scheduler":
    ensure    => running,
    enable    => true,
    require   => File["nova-default"],
    subscribe => File["/etc/nova/nova.conf"]
  }
  
}
