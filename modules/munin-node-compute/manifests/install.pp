class munin-node-compute::install {
  require "munin-node"

  package { "munin-libvirt-plugins":
    ensure => present
  }

}
