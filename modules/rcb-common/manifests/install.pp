class rcb-common::install {

  $rcb_common_packages = [ "python-eventlet" ]

  if !$package_repo {
    $package_repo = "http://devpackages.ansolabs.com"
  }

  apt::source { "rcb":
    location => $package_repo,
    release => "maverick",
    repos => "main",
    key => "460DF9BE",
    key_server => "keyserver.ubuntu.com",
    pin => "1"
  }

  package { $rcb_common_packages:
    ensure  => latest,
    require => [Apt::Source["rcb"]]
  }

}
