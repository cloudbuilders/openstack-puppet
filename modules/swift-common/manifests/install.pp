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
    
  file { '/home/swift':
    ensure  => directory,
    owner   => 'swift',
    group   => 'swift',
    mode    => 0700,
    require => User['swift']
  }
  
  file { "/etc/swift":
    ensure => directory,
    owner  => 'swift',
    group  => 'swift',
    mode   => 2770,
    require => User['swift']
  }

  package { $swift_common_packages:
    ensure  => latest,
    require => [ Apt::Source['rcb'], User['swift'] ]
  }

  package { $swift_common_misc:
    ensure  => present,
    require => Apt::Source['rcb']
  }
}
