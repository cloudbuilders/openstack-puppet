class nova-api {
  require "nova-common"
  include nova-api::install, nova-api::service
}
