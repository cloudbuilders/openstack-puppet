class omsa::config {

  file { "/etc/apt/sources.list.d/linux.dell.com.sources.list":
    ensure  => present,
    ownser  => "root",
    group   => "root",
    mode    => 0644,
    source  => "puppet:///modules/omsa/linux.dell.com.sources.list",
    notify  => Exec["gpg-keyserver"]
  }

  exec { "gpg-keyserver":
    command => "gpg --keyserver pgpkeys.mit.edu --recv-key E74433E25E3D7775",
    path => [ "/usr/bin" ],
    refreshonly => true,
    notify  => Exec["gpg-export"]
  }

  exec { "gpg-export":
    command => "gpg -a --export E74433E25E3D7775 | sudo apt-key add -",
    path => [ "/usr/bin" ],
    refreshonly => true,
    notify  => Exec["apt-update"]
  } 

  exec { "apt-update":
    command => "/usr/bin/apt-get update",
    refreshonly => true
  }
}
