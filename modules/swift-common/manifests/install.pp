class swift-common::install {
  $swift_common_packages = [ 'swift', 'swift-doc' ]
  $swift_common_misc     = [ 'dsh' ]

  file { '/etc/apt/apt.conf.d/99force-yes':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '600',
    source  => 'puppet:///modules/swift-common/apt-force-yes'
  }

  
  apt::source { 'swift':
    location => 'http://crashsite.github.com/swift_debian/lucid/',
    release  => 'lucid',
    repos    => 'main'
  }

  package { $swift_common_packages:
    ensure  => latest,
    require => Apt::Source['swift']
  }

  package { $swift_common_misc:
    ensure  => present,
    require => Apt::Source['swift']
  }
}
