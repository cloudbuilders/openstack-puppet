class glance {
  require "nova-common"
  include glance::install, glance::service, glance::images
}
