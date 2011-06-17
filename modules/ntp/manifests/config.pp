class ntp::config {
  file { "/etc/ntp.conf":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => "644",
    content => template("ntp/ntp.conf.erb"),
    require => Class["ntp::install"],
    notify  => Class["ntp::service"],
  }
}
