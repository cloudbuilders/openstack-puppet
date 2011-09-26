class network-vlan-eth1::install {

  package { "vlan":
    ensure  => latest,
  }

  file { "/etc/network/interfaces":
    content => template("network-vlan-eth1/interfaces.erb"),
    mode    => 0644,
    backup  => true,
    require => Package["vlan"],
    notify  => Exec["restart_network"]
  }

  exec { "restart_network":
    command     => "/etc/init.d/networking restart",
    path        => [ "/bin", "/usr/bin" ],
    refreshonly => true
  }
}

