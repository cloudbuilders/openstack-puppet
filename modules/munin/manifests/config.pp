class munin::config {
  file { "/etc/munin/apache.conf":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "644",
    content => template("munin/apache.conf.erb"),
    require => Class["munin::install"],
  }
}
