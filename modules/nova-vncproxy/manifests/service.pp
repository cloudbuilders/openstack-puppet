class nova-vncproxy::service {
  service { "nova-vncproxy":
    ensure    => running,
    enable    => true,
    subscribe => File["/etc/nova/nova.conf"],
    require   => Class["nova-vncproxy::install"]
  }
}
