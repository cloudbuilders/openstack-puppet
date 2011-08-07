class drbd::install {
  package { 'drbd8-utils':
    ensure => installed
  }

  exec { "fix_drbd_runlevel":
    command     =>  "update-rc.d -f drbd remove && update-rc.d drbd defaults 19",
    path        => [ "/sbin", "/usr/sbin", "/usr/bin/" ],
    unless      => "stat /etc/rc3.d/S19drbd",
    require => Package['drbd8-utils']
  }
}

