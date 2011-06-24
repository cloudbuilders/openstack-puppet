class nova-infra::install {
  # not all of these are probably requires on an infra box
  $nova_infra_packages = [ "nova-api", "nova-objectstore", "nova-scheduler", "nova-network" ]

  package { $nova_infra_packages:
    ensure => latest
  }

  file { "nova-api-paste.ini":
    path => "/etc/nova/nova-api-paste.ini",
    source  => "puppet:///modules/nova-infra/nova-api-paste.ini",
    ensure => present,
    require => [
      Package["nova-api"]
    ]
  }

}
  
