class nova-api::install {

  package { "python-keystone":
    ensure => latest,
    require => [
      Apt::Source["rcb"],
    ]
  }

  package { "nova-api":
    ensure => latest,
    require => [
      Apt::Source["rcb"],
      Package["nova-common"],
      Package["openstackx"],
      Package["python-keystone"]
    ]
  }

  file { "/etc/nova/api-paste.ini":
    ensure => present,
    content => template("nova-api/api-paste.ini.erb"),
    require => [
      Package["nova-api"]
    ]
  }
}

