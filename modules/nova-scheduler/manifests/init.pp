class nova-scheduler {
  require "nova-common"
  include nova-scheduler::install, nova-scheduler::service
}
