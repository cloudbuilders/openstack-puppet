class munin::service {
  service { "munin":
    ensure  => running,
    enable  => true,
    require => Class["munin::config"]
  }
}
