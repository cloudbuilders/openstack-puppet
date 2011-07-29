class glance::install {

  # TODO: Remove python-xattr once it is in glance packaging
  $glance_packages = [ "glance", "python-glance" ]

  package { "python-xattr":
    ensure => present
  }

  package { $glance_packages:
    ensure => latest,
    notify => [Service["apache2"], Service["nova-api"]],
    require => [
      Apt::Source["rcb"],
      Package["nova-common"],
      Package["python-xattr"]
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
  
