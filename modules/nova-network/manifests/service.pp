class nova-network::service {

  service { "nova-network":
    ensure    => running,
    enable    => true,
    start     => "rm /var/lock/nova/nova-iptables.lock.lock; start nova-network",
    hasrestart=> false,
    require   => [
      File["nova-default"],
      Package["nova-network"]
    ],
    subscribe => File["/etc/nova/nova.conf"],
  }

}
