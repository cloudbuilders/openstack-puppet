class nova-scheduler::service {

  service { "nova-scheduler":
    ensure    => running,
    enable    => true,
    subscribe => File["/etc/nova/nova.conf"],
    require => [
      File["nova-default"],
      Package["nova-scheduler"]
    ]
  }
  
}
