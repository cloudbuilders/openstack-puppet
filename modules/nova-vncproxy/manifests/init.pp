class nova-vncproxy {
  require "nova-common"
  include nova-vncproxy::install, nova-vncproxy::service
}
