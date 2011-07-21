class nova-vncproxy::install {
  require "nova-common"
  
  package { "nova-vncproxy":
    ensure => latest,
    require => [
      Package["nova-novnc"]
    ]
  }

  package { "nova-novnc":
    ensure => latest
  }

  file { "/etc/init/nova-vncproxy.conf":
    ensure => present,
    content => template("nova-vncproxy/nova-vncproxy.py.erb"),
    notify => Service["nova-vncproxy"],
  }
}
