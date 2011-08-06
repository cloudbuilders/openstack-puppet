class nova-reserve-ip::install {

  package { "mysql-client":
    ensure  => latest,
  }

  exec { "reserve_ip":
    command     => "export HOST=`hostname`; mysql -h${mysql_vip} -u${mysql_nova_user} -p${mysql_nova_password} nova -e \"update fixed_ips set host='$HOST' where address='${host_vmnet_ip}'\"",
    path        => [ "/bin", "/usr/bin" ],
    unless      => "test `hostname` == `mysql -h{mysql_vip} -u${mysql_nova_user} -p${mysql_nova_password} nova -e \"select host from fixed_ips where address='${host_vmnet_ip}'\"`",
  }
}

