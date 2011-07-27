class munin-node::service {
  service { "munin-node":
    ensure  => running,
    enable  => true,
    require => Class["munin-node::config"]
  }
}
