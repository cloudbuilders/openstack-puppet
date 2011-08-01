class rcb-common::install {

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

}
