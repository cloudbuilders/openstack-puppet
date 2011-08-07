class munin-node::config {

  # This is a general-purpose def that should libe somewhere else...
  # and was lifted from the Puppet wiki
  define kernel_mod($file, $module, $ensure = 'present') {
    case $ensure {
      default : { err ( "unknown ensure value ${ensure}" ) }
      present: {
        exec { "/bin/echo '${module}' >> '${file}'":
          unless => "/bin/grep -qFx '${module}' '${file}'"
        }
	exec { "/sbin/modprobe ${module}": unless => "/bin/grep -q '^${module} ' '/proc/modules'" }
      }
      absent: {
        exec { "/sbin/modprobe -r ${module}": onlyif => "/bin/grep -q '^${module} ' '/proc/modules'" }
        exec { "/bin/grep -vFx '${module}' '${file}' | /usr/bin/tee '${file}' > /dev/null 2>&1":
          onlyif => "/bin/grep -qFx '${module}' '${file}'"
        }
      }
    }
  }

  file { "/etc/munin/munin-node.conf":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "644",
    content => template("munin-node/munin-node.conf.erb"),
    require => Package["munin-node"],
    notify => Service["munin-node"]
  }


  # Plugin links
  
  file {"/etc/munin/plugins/cpu":
    ensure => symlink,
    target => "/usr/share/munin/plugins/cpu",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/diskstats":
    ensure => symlink,
    target => "/usr/share/munin/plugins/diskstats",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/df":
    ensure => symlink,
    target => "/usr/share/munin/plugins/df",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/df_inode":
    ensure => absent,
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/entropy":
    ensure => symlink,
    target => "/usr/share/munin/plugins/entropy",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/forks":
    ensure => symlink,
    target => "/usr/share/munin/plugins/forks",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/fw_packets":
    ensure => symlink,
    target => "/usr/share/munin/plugins/fw_packets",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/http_loadtime":
    ensure => absent,
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/interrupts":
    ensure => symlink,
    target => "/usr/share/munin/plugins/interrupts",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/iostat":
    ensure => symlink,
    target => "/usr/share/munin/plugins/iostat",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/iostat_ios":
    ensure => symlink,
    target => "/usr/share/munin/plugins/iostat_ios",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/irqstats":
    ensure => absent,
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/load":
    ensure => symlink,
    target => "/usr/share/munin/plugins/load",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/memory":
    ensure => symlink,
    target => "/usr/share/munin/plugins/memory",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/ntp_kernel_err":
    ensure => absent,
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/ntp_kernel_pll_freq":
    ensure => absent,
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/ntp_kernel_pll_off":
    ensure => absent,
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/ntp_offset":
    ensure => symlink,
    target => "/usr/share/munin/plugins/ntp_offset",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/open_files":
    ensure => absent,
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/open_inodes":
    ensure => absent,
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/processes":
    ensure => symlink,
    target => "/usr/share/munin/plugins/processes",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/proc_pri":
    ensure => absent,
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/swap":
    ensure => absent,
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/threads":
    ensure => symlink,
    target => "/usr/share/munin/plugins/threads",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/uptime":
    ensure => symlink,
    target => "/usr/share/munin/plugins/uptime",
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/users":
    ensure => absent,
    notify => Service["munin-node"],
  }

  file {"/etc/munin/plugins/vmstat":
    ensure => symlink,
    target => "/usr/share/munin/plugins/vmstat",
    notify => Service["munin-node"],
  }


  # IPMI plugin

  file {"/etc/modules":
    ensure => present,
  }

  kernel_mod { "ipmi_devintf":
    file => "/etc/modules",
    module => "ipmi_devintf",
    ensure => present,
  }

  kernel_mod { "ipmi_si":
    file => "/etc/modules",
    module => "ipmi_si",
    ensure => present,
  }

  file {"ipmi_sdr_":
    path => "/usr/share/munin/plugins/ipmi_sdr_",
    source => "puppet:///modules/munin-node/ipmi_sdr_",
    ensure => present,
  }

  file {"/etc/munin/plugin-conf.d/ipmi_sdr":
    content => template("munin-node/ipmi_sdr.conf.erb"),
    ensure => present,
    notify => Service["munin-node"],
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
}
