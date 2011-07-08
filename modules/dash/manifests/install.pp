class dash::install {
  
  $dash_common_packages = [ "git", "apache2", "libapache2-mod-wsgi" ]
  
  package { "python-django":
    ensure => "1.3-2"
  }
  
  package { $dash_common_packages:
    ensure => latest
  }
  
  package { "django-openstack":
    ensure => latest,
    notify => Service["apache2"],
    require => [
      Package["libapache2-mod-wsgi"],
      Package["python-django"],
      Package["apache2"]
    ]
  }

  package { "openstack-dashboard":
    ensure => latest,
    notify => Service["apache2"],
    require => [
      Package["python-django"],
      Package["django-openstack"]
    ]
  }

  file { "/var/lib/dash/.blackhole":
    ensure => directory,
    owner  => "www-data",
    mode   => 0755,
    require => [
      Package["openstack-dashboard"]
    ]
  }
  
  file { "django.wsgi":
    path => "/var/lib/dash/dashboard/wsgi/django.wsgi",
    source  => "puppet:///modules/dash/django.wsgi",
    ensure => present,
    require => [
      Package["openstack-dashboard"]
    ]
  }

  file { "/var/lib/dash/dashboard/local":
    ensure => link,
    target => "/var/lib/dash/local"
  }

  file { "local_settings.py":
    path => "/var/lib/dash/local/local_settings.py",
    ensure => present,
    owner  => "www-data",
    content => template("dash/local_settings.py.erb"),
    require => [
      Package["openstack-dashboard"],
      File["/var/lib/dash/dashboard/local"]
    ]
  }

  # FIXME: trigger restart doesn't work because notify causes cyclical graph
  file { "apache-site":
    path => "/etc/apache2/sites-enabled/000-default",
    ensure => present,
    source => "puppet:///modules/dash/000-default",
    require => [
      Package["apache2"],
      Exec["dash-db"],
      File["django.wsgi"]
    ]
  }

  # Enable mod_rewrite to allow the overlay of custom images and css
  file {"/etc/apache2/mods-enabled/rewrite.load":
    ensure => symlink,
    target => "/etc/apache2/mods-available/rewrite.load",
    notify => Service["apache2"]
  }

  exec { "dash-db":
    command => "python /var/lib/dash/dashboard/manage.py syncdb",
    user => "www-data",
    path => "/usr/bin:/bin",
    unless => "test -f /var/lib/dash/local/dashboard_openstack.sqlite3",
    require => [
      Package["openstack-dashboard"],
      File["local_settings.py"]
    ]
  }
}
