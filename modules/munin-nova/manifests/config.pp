class munin-nova::config {

  file {"keystone_stats":
    path => "/usr/share/munin/plugins/keystone_stats",
    source => "puppet:///modules/munin-nova/keystone_stats",
    ensure => present,
  }

  file {"/etc/munin/plugins/keystone_stats":
    ensure => symlink,
    target => "/usr/share/munin/plugins/keystone_stats",
    notify => Service["munin-node"],
  }

  file {"nova_floating_ips":
    path => "/usr/share/munin/plugins/nova_floating_ips",
    source => "puppet:///modules/munin-nova/nova_floating_ips",
    ensure => present,
  }

  file {"/etc/munin/plugins/nova_floating_ips":
    ensure => symlink,
    target => "/usr/share/munin/plugins/nova_floating_ips",
    notify => Service["munin-node"],
  }

  file {"nova_instance_launched":
    path => "/usr/share/munin/plugins/nova_instance_launched",
    source => "puppet:///modules/munin-nova/nova_instance_launched",
    ensure => present,
  }

  file {"/etc/munin/plugins/nova_instance_launched":
    ensure => symlink,
    target => "/usr/share/munin/plugins/nova_instance_launched",
    notify => Service["munin-node"],
  }

  file {"nova_instance_states":
    path => "/usr/share/munin/plugins/nova_instance_states",
    source => "puppet:///modules/munin-nova/nova_instance_states",
    ensure => present,
  }

  file {"/etc/munin/plugins/nova_instance_states":
    ensure => symlink,
    target => "/usr/share/munin/plugins/nova_instance_states",
    notify => Service["munin-node"],
  }

  file {"nova_instance_timing":
    path => "/usr/share/munin/plugins/nova_instance_timing",
    source => "puppet:///modules/munin-nova/nova_instance_timing",
    ensure => present,
  }

  file {"/etc/munin/plugins/nova_instance_timing":
    ensure => symlink,
    target => "/usr/share/munin/plugins/nova_instance_timing",
    notify => Service["munin-node"],
  }

  file {"nova_services":
    path => "/usr/share/munin/plugins/nova_services",
    source => "puppet:///modules/munin-nova/nova_services",
    ensure => present,
  }

  file {"/etc/munin/plugins/nova_services":
    ensure => symlink,
    target => "/usr/share/munin/plugins/nova_services",
    notify => Service["munin-node"],
  }
}
