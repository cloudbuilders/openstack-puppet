class glance::images {

  file { "inital_images.sh":
    path => "/var/lib/glance/inital_images.sh",
    ensure  => present,
    owner   => "glance",
    mode    => 0700,
    source  => "puppet:///modules/glance/inital_images.sh",
    require => Package["glance"]
  }

}
  
