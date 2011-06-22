class swift-common::config {
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
    mode   => '2700',
    require => User['swift']
  }

  file { "/etc/swift/swift.conf":
    ensure  => present,
    owner   => 'swift',
    group   => 'swift',
    mode    => 0660,
    content => template('swift-common/swift.conf.erb'),
    require => File["/etc/swift"]
  }
}
