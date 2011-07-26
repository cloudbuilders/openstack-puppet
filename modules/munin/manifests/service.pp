class munin::service {
  service { "munin-node":
    ensure  => running,
    enable  => true,
    require => Class["munin::config"]
  }
}
