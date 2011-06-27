class nova-compute::install {
  require "nova-common"
  
  package { "nova-compute":
    ensure => latest
  }
  
  file { "/root/fix_iptables.sh":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "755",
    source  => "puppet:///modules/nova-compute/fix_iptables.sh",
  }
  
}
