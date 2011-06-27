class nova-compute::service {
  service { "nova-compute":
    ensure    => running,
    enable    => true,
    subscribe => File["/etc/nova/nova.conf"],
    require   => Class["nova-compute::install"]
  }
  
  exec { "fix_iptables.sh":
    command => "/root/fix_iptables.sh",
    user => "root",
    path => "/usr/bin:/bin:/sbin:/usr/sbin",
    require => [
      File["/root/fix_iptables.sh"]
    ]
  }
  
}
