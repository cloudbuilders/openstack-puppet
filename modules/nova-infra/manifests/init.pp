class nova-infra {
  require "nova-common"
  include nova-infra::install, nova-infra::service
}
