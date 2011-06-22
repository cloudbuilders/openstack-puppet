class dash::install {
  
  $dash_common_packages = [ "git", "apache2", "libapache2-mod-wsgi", "python-django", "python-django-nose" ]
  
  package { $dash_common_packages:
    ensure => latest
  }
  
  package { "django-openstack":
    ensure => present,
    require => [
      Package["python-django"],
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

  file { "/var/lib/dash/openstack-dashboard/dashboard/local":
    ensure => link,
    target => "/var/lib/dash/openstack-dashboard/local"
  }

  file { "local_settings.py":
    path => "/var/lib/dash/openstack-dashboard/local/local_settings.py",
    ensure => present,
    owner  => "www-data",
    source  => "puppet:///modules/dash/local_settings.py",
    require => [
      Exec["dash-checkout"],
      File["/var/lib/dash/openstack-dashboard/dashboard/local"]
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
    command => "python /var/lib/dash/openstack-dashboard/dashboard/manage.py syncdb",
    user => "www-data",
    path => "/usr/bin:/bin",
    require => [
      Exec["dash-checkout"],
      File["local_settings.py"]
    ]
  }
}
