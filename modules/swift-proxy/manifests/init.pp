class swift-proxy {
  if $use_swauth {
    require "swift-swauth"
  }
  
  include swift-proxy::install, swift-proxy::config, swift-proxy::service
}
