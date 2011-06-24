class glance::images {

  file { "initial_images.sh":
    path => "/var/lib/glance/initial_images.sh",
    ensure  => present,
    owner   => "glance",
    mode    => 0700,
    source  => "puppet:///modules/glance/initial_images.sh",
    require => Package["glance"]
  }

}
  
