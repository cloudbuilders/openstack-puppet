class nova-api::service {

  service { "nova-api":
    ensure    => running,
    enable    => true,
    require   => [
      File["nova-default"],
      File["api-paste.ini"]
    ],
    subscribe => [
      File["/etc/nova/nova.conf"],
      File["api-paste.ini"]
    ]
  }
  
}
