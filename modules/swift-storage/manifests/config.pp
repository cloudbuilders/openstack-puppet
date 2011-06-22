class swift-storage::config {
  require 'swift-storage::install'

  file { '/etc/rsyncd.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 0660,
    content => template('swift-storage/rsyncd.conf.erb')
  }

  file { '/etc/default/rsync':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => 0664,
    source => 'puppet:///modules/swift-storage/rsync.default'
  }

  # we'll templatize these in case we want to
  # add options later
  #
  file { '/etc/swift/account-server.conf':
    ensure  => present,
    owner   => 'swift',
    group   => 'swift',
    mode    => 0660,
    content => template('swift-storage/account-server.conf.erb')
  }

  file { '/etc/swift/container-server.conf':
    ensure  => present,
    owner   => 'swift',
    group   => 'swift',
    mode    => 0660,
    content => template('swift-storage/container-server.conf.erb')
  }

  file { '/etc/swift/object-server.conf':
    ensure  => present,
    owner   => 'swift',
    group   => 'swift',
    mode    => 0660,
    content => template('swift-storage/object-server.conf.erb')
  }

}
