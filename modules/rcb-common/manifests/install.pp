class rcb-common::install {

  if !$package_repo {
    $package_repo = "http://devpackages.ansolabs.com"
  }

  if !$package_component {
    $package_component = "main"
  }

  # remove this once we get packages signed
  file { '/etc/apt/apt.conf.d/98allow-unauthenticated':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '600',
    content => 'APT::Get::AllowUnauthenticated "yes";'
  }

  file { '/etc/apt/preferences.d/rcb':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '600',
    content => template('rcb-common/rcb.erb')
  }  

  apt::source { "rcb":
    location => $package_repo,
    release => "$package_release",
    repos => "$package_component",
    key => "460DF9BE",
    key_server => "keyserver.ubuntu.com",
    notify => Exec["apt-update"]
  }

  exec { "apt-update":
    command => "/usr/bin/apt-get update",
    require => Apt::Source["rcb"],
    refreshonly => true
  }


}
