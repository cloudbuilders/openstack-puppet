# TODO: (rp) This should have a rabbitmq::master and rabbitmq::slave
# for HA config
if $use_ha {
  require "drbd"
}
  
class rabbitmq {
  include rabbitmq::install, rabbitmq::config, rabbitmq::service
}
