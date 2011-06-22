class swift-proxy::install {
  require "swift-common"

  $swift_proxy_packages = [ 'swift-proxy', 'memcached' ]

  package { $swift_proxy_packages:
    ensure => present
  }
}
