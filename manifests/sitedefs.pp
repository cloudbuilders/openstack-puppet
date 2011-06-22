# Array of NTP servers to use
# FIXME: (rp) move this crap to cluster config yaml file
$ntpservers = [ "0.debian.pool.ntp.org", "1.debian.pool.ntp.org", "2.debian.pool.ntp.org" ]

# In full apt format, e.g. "deb http://foo.com/ubuntu maverick main contrib"
$additional_apt_repos = []

$cluster_name="test"

class base-node {
  include ssh
  include sudo
  include ntp
  include apt  # additional repos only
}

class nova-base-node {
  include base-node
  include nova-common
}

class nova-compute-node {
  include nova-base-node
  include nova-compute
}

class nova-infra-node {
  # These should be split into:
  #  * rabbit
  #  * mysql
  #  * api
  #  * scheduler
  include nova-base-node
  include mysql::server
  include nova-db
  include rabbitmq
  include nova-infra
  include glance
  include dash
}

class swift-common-node {
  include base-node
  include swift-common
}

class swift-proxy-node {
  include swift-common-node
  include swift-proxy
}

class swift-storage-node {
  include swift-common-node
  include swift-storage
}
