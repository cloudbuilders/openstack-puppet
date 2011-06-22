class swift-proxy::service {
  require 'swift-proxy::config'

  service { 'swift-proxy':
    ensure => running,
    enable => true
  }

  service { 'memcached':
    ensure => running,
    enable => true
  }
}
  
