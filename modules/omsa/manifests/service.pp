class omsa::service {

  service { "dataeng":
    ensure => running,
    enable => true,
    require => Class["omsa::install"]
  }

  exec { "omsa-webserver-user":
    command => "echo 'demo	*	Administrator' >> /opt/dell/srvadmin/etc/omarolemap",
    refreshonly => true,
    path => [ '/bin' ],
    require => Class["omsa::install"],
    notify  => Service["dsm_om_connsvc"]
  }

  service { "dsm_om_connsvc":
    ensure => running,
    enable => true,
    require => Class["omsa::install"]
  }

}
