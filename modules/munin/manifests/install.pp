class munin::install {
  package { "munin":
    ensure => present,
    require => [
      Service["apache2"]
    ],
  }

  file { "/etc/apache2/conf.d/munin":
    ensure => link,
    target => "/etc/munin/apache.conf",
    require => [
      Package["munin"]
    ],
    notify => [
      Service["apache2"]
    ]
  }
}
