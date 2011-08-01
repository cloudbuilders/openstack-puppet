class munin-node::install {
  package { "munin-node":
    ensure => present
  }
}
