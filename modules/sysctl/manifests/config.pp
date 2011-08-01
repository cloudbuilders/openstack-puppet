class sysctl::config {
  file { "/etc/sysctl.d/99-forwarding.conf":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => 0444,
    source  => "puppet:///modules/sysctl/99-forwarding.conf",
    notify  => Exec["load_sysctl"]
  }

  exec { "load_sysctl":
    command     => "/sbin/sysctl -p /etc/sysctl.d/99-forwarding.conf",
    path        => [ "/bin", "/usr/bin" ],
    refreshonly => true
  }
}

