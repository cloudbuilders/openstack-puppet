class nova-network::install {

  package { "nova-network":
    ensure => latest,
    require => [
      File["nova-default"],
      Apt::Source["rcb"]
    ]
  }

}
  
