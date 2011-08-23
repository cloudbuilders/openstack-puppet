class omsa::config {

  file { "/etc/apt/sources.list.d/linux.dell.com.sources.list":
    ensure  => present,
    ownser  => "root",
    group   => "root",
    mode    => 0644,
    source  => "puppet:///modules/omsa/linux.dell.com.sources.list",
    notify  => Exec["apt-update"]
  }

  exec { "apt-update":
    command => "/usr/bin/apt-get update",
    refreshonly => true
  }
}
