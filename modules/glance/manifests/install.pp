class glance::install {

  $glance_packages = [ "glance", "python-glance" ]

  package { $glance_packages:
    ensure => present,
    require => [
      Class["rcb-common"]
    ]
  }

  file { "/var/log/glance":
    ensure => directory,
    owner  => "glance",
    mode   => 0755
  }

  file { "/var/log/glance/api.log":
    ensure => present,
    owner  => "glance",
    mode   => 0600,
    require => File["/var/log/glance"]
  }

}
  
