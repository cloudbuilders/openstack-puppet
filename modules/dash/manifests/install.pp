class dash::install {

  package { "git":
    ensure => present
  }

  package { "apache2":
    ensure => present
  }

  package { "libapache2-mod-wsgi":
    ensure => present
  }

  package { "django-openstack":
    ensure => present,
    require => [
      Package["libapache2-mod-wsgi"],
      Package["apache2"]
    ]
  }

  file { "/var/lib/dash/":
    ensure => directory,
    owner  => "www-data",
    mode   => 0755,
    require => [
      Package["apache2"]
    ]
  }

  exec { "dash-checkout":
    command => "git clone git://github.com/cloudbuilders/openstack-dashboard.git -b trunk_safe /var/lib/dash",
    unless => "test -d /var/lib/dash/.git",
    path => "/usr/bin:/bin",
    user => "www-data",
    require => [
      Package["django-openstack"]
    ]
  }

  file { "/var/lib/dash/.blackhole":
    ensure => directory,
    owner  => "www-data",
    mode   => 0755,
    require => [
      Exec["dash-checkout"]
    ]
  }

  file { "/var/lib/dash/openstack-dashboard/local_settings.py":
    ensure => present,
    owner  => "www-data",
    source  => "puppet:///modules/dash/local_settings.py",
    require => [
      Exec["dash-checkout"]
    ]
  }

  # FIXME: trigger restart
  file { "/etc/apache2/sites-enabled/000-default":
    ensure => present,
    source => "puppet:///modules/dash/000-default",
    require => [
      Package["apache2"]
    ]
  }

  exec { "dash-db":
    command => "python /var/lib/dash/opesntack-dashboard/dashboard/manage.py syncdb",
    user => "www-data",
    path => "/usr/bin:/bin",
    require => [
      Exec["dash-checkout"]
    ]
  }
}
