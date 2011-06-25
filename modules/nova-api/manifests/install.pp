class nova-api::install {

  package { "nova-api":
    ensure => latest
  }

  file { "nova-api-paste.ini":
    path => "/etc/nova/nova-api-paste.ini",
    source  => "puppet:///modules/nova-api/nova-api-paste.ini",
    ensure => present,
    require => [
      Package["nova-api"]
    ]
  }

}
  
