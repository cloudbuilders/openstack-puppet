class swift-common::install {
  $swift_common_packages = [ 'swift', 'swift-doc' ]
  $swift_common_misc     = [ 'dsh' ]

  group { 'swift':
    ensure => present,
    gid    => 500
  }
  
  user { 'swift':
    ensure  => present,
    uid     => 500,
    gid     => 'swift',
    require => Group['swift']
  }
    
  file { "/etc/swift":
    ensure => directory,
    owner  => 'swift',
    group  => 'swift',
    mode   => 2770,
    require => User['swift']
  }

  # hack, should ask swift guys to sign packages
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
    repos    => 'main',
    require  => File['/etc/apt/apt.conf.d/99force-yes']
  }

  package { $swift_common_packages:
    ensure  => latest,
    require => [ Apt::Source['swift'], User['swift'] ]
  }

  package { $swift_common_misc:
    ensure  => present,
    require => Apt::Source['swift']
  }
}
