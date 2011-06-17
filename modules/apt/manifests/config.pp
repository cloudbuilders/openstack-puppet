class apt::config {
  file { "/etc/apt/sources.list.d":
    ensure => directory,
    owner  => "root",
    group  => "root",
    mode   => 0755,
  }

  file { "sources_list":
    path    => $apt_sources_list,
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => 0640,
    content => template($apt_templ_source),
    notify  => Exec["apt-update"],
    require => File["/etc/apt/sources.list.d"]
  }

  exec { "apt-update":
    command     => "/usr/bin/apt-get update",
    refreshonly => true
  }
}

