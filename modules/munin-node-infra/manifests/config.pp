class munin-node-infra::config {
  file {"/etc/munin/plugins/apache_accesses":
    ensure => symlink,
    target => "/usr/share/munin/plugins/apache_accesses",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/apache_processes":
    ensure => absent,
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/apache_volume":
    ensure => symlink,
    target => "/usr/share/munin/plugins/apache_volume",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/munin_stats":
    ensure => symlink,
    target => "/usr/share/munin/plugins/munin_stats",
    notify => Service["munin-node"],
  }
}
