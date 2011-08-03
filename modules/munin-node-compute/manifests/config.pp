class munin-node-compute::config {
  file {"/etc/munin/plugins/libvirt-blkstat":
    ensure => symlink,
    target => "/usr/share/munin/plugins/libvirt-blkstat",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/libvirt-cputime":
    ensure => symlink,
    target => "/usr/share/munin/plugins/libvirt-cputime",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/libvirt-ifstat":
    ensure => symlink,
    target => "/usr/share/munin/plugins/libvirt-ifstat",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/libvirt-mem":
    ensure => symlink,
    target => "/usr/share/munin/plugins/libvirt-mem",
    notify => Service["munin-node"],
  }
}
