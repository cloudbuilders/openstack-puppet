class haproxy::config {
  file { "/etc/haproxy/haproxy.cfg":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "644",
    content => template("haproxy/haproxy.cfg.erb"),
    require => Class["haproxy::install"],
    notify  => Class["haproxy::service"],
  }
  file { "haproxy-default":
    path => "/etc/default/haproxy",
    content => "ENABLED=1",
    require => Package["haproxy"]
  }
}
