class swift-proxy {
  if $use_swauth {
    require "swift-swauth"
  }
  if $use_keystone {
     require "swift-keystone"
  }
  include swift-proxy::install, swift-proxy::config, swift-proxy::service
}
