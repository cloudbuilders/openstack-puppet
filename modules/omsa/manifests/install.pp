class omsa::install {

  apt::source { "dell-omsa":
    location => "http://linux.dell.com/repo/community/deb/latest",
    release => "/",
    repos => "",
    include_src => false,
    key => "E74433E25E3D7775",
    key_server => "pgpkeys.mit.edu",
    notify  => Exec["apt-update"]
  }

  exec { "apt-update":
    command => "/usr/bin/apt-get update",
    refreshonly => true,
    notify => Package["srvadmin-all"]
  }

  package { "srvadmin-all":
    ensure => present,
    notify => Class["omsa::service"]
  }
}
