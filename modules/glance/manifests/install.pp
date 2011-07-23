class glance::install {

  $glance_packages = [ "glance", "python-glance" ]

  package { $glance_packages:
    ensure => present,
    require => [
      Apt::Source["rcb"],
      Package["nova-common"]
    ]
  }

  file { "/var/log/glance":
    ensure => directory,
    owner  => "glance",
    mode   => 0755,
    require => [Package["glance"], Package["python-glance"]]
  }

  file { "/var/log/glance/api.log":
    ensure => present,
    owner  => "glance",
    mode   => 0600,
    require => File["/var/log/glance"]
  }

}
  
