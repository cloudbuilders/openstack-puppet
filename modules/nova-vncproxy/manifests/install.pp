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
}
