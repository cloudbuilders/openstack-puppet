# TODO: (rp) This should have a rabbitmq::master and rabbitmq::slave
# for HA config

class rabbitmq {
  include rabbitmq::install, rabbitmq::service
}
