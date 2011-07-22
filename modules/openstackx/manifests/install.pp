class openstackx::install {
  package { openstackx:
    ensure => latest,
    notify => [Service["apache2"], Service["nova-api"]],
    require => [
      Class["rcb-common"]
    ]
  }
}

