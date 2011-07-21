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
    source  => "puppet:///modules/nova-vncproxy/nova-vncproxy.conf",
    notify => Service["nova-vncproxy"]
  }
}
