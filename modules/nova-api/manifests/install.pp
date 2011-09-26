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

  file { "api-paste.ini":
    path => "/etc/nova/api-paste.ini",
    source  => "puppet:///modules/nova-api/api-paste.ini",
    ensure => present,
    require => [
      Package["nova-api"]
    ]
  }
}
  
