class nova-compute::service {
  service { "nova-compute":
    ensure    => running,
    enable    => true,
    start     => "rm /var/lock/nova/nova-iptables.lock.lock; start nova-compute",
    hasrestart=> false,
    subscribe => File["/etc/nova/nova.conf"],
    require   => Class["nova-compute::install"]
  }

  exec { "fix_iptables.sh":
    command => "/root/fix_iptables.sh",
    user => "root",
    path => "/usr/bin:/bin:/sbin:/usr/sbin",
    subscribe => Service["nova-compute"],
    require => [
      File["/root/fix_iptables.sh"]
    ]
  }

}
