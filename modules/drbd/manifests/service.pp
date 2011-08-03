class drbd::service {
  service { "drbd":
    ensure  => running,
    enable  => true,
    require => Class['drbd::install']
  }    
}
