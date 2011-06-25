class nova-common::config {
  # set up the nova.conf
  file { "/etc/nova/nova.conf":
    ensure  => present,
    owner   => "root",
    group   => "nogroup",
    mode    => 0660,
    content => template("nova-common/nova.conf.erb"),
    require => Class["nova-common::install"]
  }
  # set permissions for /dev/kvm
  file { "/dev/kvm":
    ensure  => present,
    owner   => root,
    group   => kvm,
    mode    => 0775
  }
}
