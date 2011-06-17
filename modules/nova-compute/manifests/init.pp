class nova-compute {
  require "nova-common"
  include nova-compute::install, nova-compute::service
}
  
