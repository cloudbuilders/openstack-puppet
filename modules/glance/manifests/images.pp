class glance::images {

  file { "initial_images.sh":
    path => "/var/lib/glance/initial_images.sh",
    ensure  => present,
    owner   => "glance",
    mode    => 0700,
    source  => "puppet:///modules/glance/initial_images.sh",
    require => Package["glance"]
  }
  
  exec { "install-images":
    command => "/var/lib/glance/initial_images.sh",
    user => "glance",
    path => "/usr/bin:/bin",
    unless => "test -f /var/lib/glance/images/1",
    require => [
      Service["glance-api"],
      Service["nova-api"],
      Service["glance-registry"],
      File["initial_images.sh"]
    ]
  }

}
  
