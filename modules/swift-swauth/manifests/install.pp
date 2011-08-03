class swift-swauth::install {
  $swauth_common_packages = [ 'python-swauth' ]

  apt::source { 'swauth':
    location => 'http://gholt.github.com/swauth/lucid',
    release  => 'lucid',
    repos    => 'main',
    require  => File['/etc/apt/apt.conf.d/99force-yes']
  }

  package { $swauth_common_packages:
    ensure  => latest,
    require => Apt::Source['swauth']
  }
}
