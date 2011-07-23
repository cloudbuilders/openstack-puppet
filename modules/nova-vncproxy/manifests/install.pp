class nova-vncproxy::install {
  require "nova-common"
  
  package { "nova-vncproxy":
    ensure => latest,
    require => [
      Apt::Source["rcb"],
      Package["nova-novnc"],
    ]
  }

  package { "nova-novnc":
    ensure => latest,
    notify => Service["nova-vncproxy"],
    require => [
      Apt::Source["rcb"],
    ]
  }

  file { "/etc/init/nova-vncproxy.conf":
    source  => "puppet:///modules/nova-vncproxy/nova-vncproxy.conf",
    notify => Service["nova-vncproxy"]
  }
}
