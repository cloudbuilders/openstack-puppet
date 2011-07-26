class munin::install {
  package { "munin-node":
    ensure => present
  }
}
