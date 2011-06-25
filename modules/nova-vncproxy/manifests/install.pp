class nova-vncproxy::install {
  require "nova-common"
  
  package { "nova-vncproxy":
    ensure => latest
  }
}
