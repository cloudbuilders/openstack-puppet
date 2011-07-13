# Array of NTP servers to use
# FIXME: (rp) move this crap to cluster config yaml file
$ntpservers = [ "0.debian.pool.ntp.org", "1.debian.pool.ntp.org", "2.debian.pool.ntp.org" ]

# In full apt format, e.g. "deb http://foo.com/ubuntu maverick main contrib"
$additional_apt_repos = []

$cluster_name="test"

class one-vm-vlan {
  include vm-vlan-network
}

class base-node {
  include ssh
  include sudo
  include ntp
  include apt  # additional repos only
}

class nova-base-node {
  include cloudkick
  include base-node
  include nova-common
}

class nova-compute-node {
  include nova-base-node
  include nova-compute
}

class nova-infra-node {
  include nova-base-node

  # data services
  include rabbitmq
  include mysql::server

  # database setup
  include nova-db

  # openstack services
  include nova-api
  include nova-network
  include nova-scheduler
  include nova-vncproxy

  include glance
  include dash
  include keystone
  include openstackx
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
