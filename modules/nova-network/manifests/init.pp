class nova-network {
  require "nova-common"
  include nova-network::install, nova-network::service
}
