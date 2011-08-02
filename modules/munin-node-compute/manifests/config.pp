class munin-node-infra::config {
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


  file {"ipmi_sdr_":
    path => "/usr/share/munin/plugins/ipmi_sdr_",
    source => "puppet:///modules/munin-node-compute/ipmi_sdr_",
    ensure => present,
  }

  file {"/etc/munin/plugins/ipmi_sdr_current":
    ensure => symlink,
    target => "/usr/share/munin/plugins/ipmi_sdr_",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/ipmi_sdr_fan":
    ensure => symlink,
    target => "/usr/share/munin/plugins/ipmi_sdr_",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/ipmi_sdr_temperature":
    ensure => symlink,
    target => "/usr/share/munin/plugins/ipmi_sdr_",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/ipmi_sdr_voltage":
    ensure => symlink,
    target => "/usr/share/munin/plugins/ipmi_sdr_",
    notify => Service["munin-node"],
  }


  file {"/etc/munin/plugin-conf.d/ipmi_sdr":
    content => template("munin-node-compute/ipmi_sdr.conf.erb"),
    ensure => present,
    notify => Service["munin-node"],
  }


}
