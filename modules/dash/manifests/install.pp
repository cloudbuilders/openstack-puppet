class dash::install {

  package { "apache2":
    ensure => present
  }

  package { "libapache2-mod-wsgi":
    ensure => present
  }

  package { "django-openstack":
    ensure => present
  }


  file { "/var/lib/dash/":
    ensure => directory,
    owner  => "www-data",
    mode   => 0755
  }

  exec { "dash checkout":
    command => "git clone git://github.com/cloudbuilders/openstack-dashboard.git -b trunk_safe /var/lib/dash",
    owner => "www-data",
    group => "www-data",
    require => [
      Package["apache2"],
      Package["libapache2-mod-wsgi"],
      Package["django-openstack"]
    ]
  }

  file { "/var/lib/dash/.blackhole":
    ensure => directory,
    owner  => "www-data",
    mode   => 0755
  }

  file { "/var/lib/dash/openstack-dashboard/local_settings.py":
    ensure => present,
    owner  => "www-data",
    content => "import os

DEBUG = True
TEMPLATE_DEBUG = DEBUG
PROD = False
USE_SSL = False

LOCAL_PATH = os.path.dirname(os.path.abspath(__file__))
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(LOCAL_PATH, 'dashboard_openstack.sqlite3'),
    },
}

CACHE_BACKEND = 'dummy://'

# Configure these for your outgoing email host
# EMAIL_HOST = 'smtp.my-company.com'
# EMAIL_PORT = 25
# EMAIL_HOST_USER = 'djangomail'
# EMAIL_HOST_PASSWORD = 'top-secret!'

NOVA_DEFAULT_ENDPOINT = 'http://localhost:8773/services/Cloud'
NOVA_DEFAULT_REGION = 'nova'
NOVA_ACCESS_KEY = 'admin'
NOVA_SECRET_KEY = 'admin'
NOVA_ADMIN_USER = 'admin'
NOVA_PROJECT = 'admin'

# Configure these for your outgoing email host
# EMAIL_HOST = 'smtp.my-company.com'
# EMAIL_PORT = 25
## EMAIL_HOST_USER = 'djangomail'
## EMAIL_HOST_PASSWORD = 'top-secret!'
",
  }

  file { "/var/lib/dash/opesntack-dashboard/dashboard/wsgi/local.wsgi":
    ensure => present,
    owner  => "www-data",
    content => "import sys
sys.path.append('/opt/dash/openstack-dashboard/.dashboard-venv/lib/python2.6/site-packages/')
sys.path.append('/opt/dash/openstack-dashboard/.dashboard-venv/lib/python2.7/site-packages/')
sys.path.append('/opt/dash/openstack-dashboard/')
sys.path.append('/opt/dash/django-openstack/src/')
sys.path.append('/opt/openstackx')
sys.path.append('/opt/dash/openstack-dashboard/.dashboard-venv/src/openstack')"
  }

  file { "/etc/apache2/sites-enabled/000-default":
    ensure => present,
    content => "<VirtualHost *:80>
    WSGIScriptAlias / $DASH_DIR/openstack-dashboard/dashboard/wsgi/local.wsgi
    WSGIDaemonProcess dashboard user=www-data group=www-data processes=3 threads=10
    WSGIProcessGroup dashboard

    DocumentRoot $DASH_DIR/.blackhole/
    Alias /media $DASH_DIR/openstack-dashboard/media

    <Directory />
        Options FollowSymLinks
        AllowOverride None
    </Directory>

    <Directory $DASH_DIR/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride None
        Order allow,deny
        allow from all
    </Directory>

    ErrorLog /var/log/apache2/error.log
    LogLevel warn
    CustomLog /var/log/apache2/access.log combined
</VirtualHost>"
  }

  exec { "dash db":
    command => "python /var/lib/dash/opesntack-dashboard/dashboard/manage.py syncdb",
    user => "www-data",
  }
}
