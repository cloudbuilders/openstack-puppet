class nova-network::install {

  package { "nova-network":
    ensure => latest
  }

}
  
