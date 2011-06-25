class nova-vncproxy::install {
  require "nova-common"
  
  package { "nova-vncproxy":
    ensure => latest
  }

  package { "nova-novnc":
    ensure => latest
  }
}
