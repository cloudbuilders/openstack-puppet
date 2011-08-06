class nova-reserve-ip::install {

  package { "mysql":
    ensure  => latest,
  }

  exec { "reserve_ip":
    command     => "HOST=`hostname`; mysql -u${mysql_nova_user} -p${mysql_nova_password} nova -e \"update fixed_ips set host='$HOST' where address='${host_vmnet_ip}'\"",
    path        => [ "/bin", "/usr/bin" ],
    unless      => "test `hostname` == `mysql -u${mysql_nova_user} -p${mysql_nova_password} nova -e \"select host from fixed_ips where address='${host_vmnet_ip}'\"`",
  }
}

