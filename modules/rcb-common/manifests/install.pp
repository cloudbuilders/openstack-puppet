class rcb-common::install {

  if !$package_repo {
    $package_repo = "http://devpackages.ansolabs.com"
  }

  if !$package_component {
    $package_component = "main"
  }

  apt::source { "rcb":
    location => $package_repo,
    release => "maverick",
    repos => "$package_component",
    key => "460DF9BE",
    key_server => "keyserver.ubuntu.com",
    pin => "1",
    notify => Exec["apt-update"]
  }

  exec { "apt-update":
    command => "/usr/bin/apt-get update",
    require => Apt::Source["rcb"],
    refreshonly => true
  }


}
