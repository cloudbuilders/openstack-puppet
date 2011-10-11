class haproxy::config {
  file { "/etc/haproxy/haproxy.conf":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "644",
    content => template("haproxy/haproxy.conf.erb"),
    require => Class["haproxy::install"],
    notify  => Class["haproxy::service"],
  }
}
