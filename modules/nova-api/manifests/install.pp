class nova-api::install {

  package { "nova-api":
    ensure => latest
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
  
