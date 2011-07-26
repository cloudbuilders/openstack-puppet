class munin::config {
  file { "/etc/munin/munin-node.conf":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "644",
    content => template("munin/munin-node.conf.erb"),
    require => Class["ntp::install"],
    notify  => Class["ntp::service"],
  }
}
