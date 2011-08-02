class munin-node-infra::install {
  require "munin-node"

  package { "munin-libvirt-plugins":
    ensure => present
  }

}
