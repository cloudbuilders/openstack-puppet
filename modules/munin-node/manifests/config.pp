class munin-node::config {
  file { "/etc/munin/munin-node.conf":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "644",
    content => template("munin-node/munin-node.conf.erb"),
    require => Class["munin-node::install"],
    notify  => Class["munin-node::service"],
  }
}
