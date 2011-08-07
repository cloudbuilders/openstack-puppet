class nova-common::config {
  # set up the nova.conf
  file { "/etc/nova/nova.conf":
    ensure  => present,
    owner   => "nova",
    group   => "nogroup",
    mode    => 0660,
    content => template("nova-common/nova.conf.erb"),
    require => Package["nova-common"]
  }
  file { "/usr/share/pyshared/nova/virt/libvirt.xml.template":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 0644,
    content => template("nova-common/libvirt.xml.template.erb"),
    require => Package["nova-common"]
  }
}
