# Site config
import "classes/*"

# Array of NTP servers to use
# FIXME: (rp) move this crap to cluster config yaml file
$ntpservers = [ "0.debian.pool.ntp.org", "1.debian.pool.ntp.org", "2.debian.pool.ntp.org" ]

# In full apt format, e.g. "deb http://foo.com/ubuntu maverick main contrib"
$additional_apt_repos = []

$cluster_name="test"

class base-node {
  include ssh
  include ntp
  include apt  # additional repos only
}

class nova-base-node {
  include base-node

  class { 'apt::launchpad_repo':
    repo_name       => "nova-trunk",
    apt_url         => "http://ppa.launchpad.net/nova-core/trunk/ubuntu",
    apt_keyserver   => "keyserver.ubuntu.com",
    apt_signing_key => "7A4AF09AB1802509C26153211EBA3D372A2356C9"
  }

  include nova-common
}

class nova-compute-node {
  include nova-base-node
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
  include nova-compute-node
}

# TODO: (rp)
# external node classifier based on cluster yaml file
node "puppet-client" {
  include nova-infra-node
}
