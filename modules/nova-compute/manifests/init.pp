class nova-compute {
  require "nova-common"
  include nova-compute::install, nova-compute::service

  # set permissions for /dev/kvm
  file { "/dev/kvm":
    ensure  => present,
    owner   => root,
    group   => kvm,
    mode    => 0775
  }
}

