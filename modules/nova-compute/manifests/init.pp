class nova-compute {
  require "nova-common"
  include nova-compute::install, nova-compute::service

  # set permissions for /dev/kvm
  file { "/dev/kvm":
    ensure  => present,
    owner   => root,
    group   => kvm,
    mode    => 0775,
    require => Package["nova-compute"]
  }
  
  # LIBVIRT adds a default network ... we need to kill it!
  exec { "kill-libvirt-default-net":
    command => "virsh net-destroy default; rm /etc/libvirt/qemu/networks/autostart/default.xml",
    path => "/usr/bin:/bin",
    onlyif => "test -f /etc/libvirt/qemu/networks/autostart/default.xml"
  }

}

