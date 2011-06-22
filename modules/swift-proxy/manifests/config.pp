class swift-proxy::config {
  require "swift-proxy::install"

  file { "/etc/swift/proxy-server.conf":
    ensure  => present,
    owner   => 'swift',
    group   => 'swift',
    mode    => 0660,
    content => template('swift-proxy/proxy-server.conf.erb')
  }

  # file { "/etc/memcached.conf":
  #   ensure  => present,
  # }

}
