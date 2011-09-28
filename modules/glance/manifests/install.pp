class glance::install {
  # TODO: Remove python-xattr once it is in glance packaging
  $glance_packages = [ "glance", "python-glance", "python-swift" ]

  package { "python-xattr":
    ensure => present
  }

  # ha configs require synced uid/gid
  user { "glance":
    ensure  => present,
    uid     => 504,
    gid     => 65534,
    home    => "/var/lib/glance",
    shell   => "/bin/bash"
  }

  package { $glance_packages:
    ensure => latest,
    notify => [Service["apache2"], Service["nova-api"]],
    require => [
      Apt::Source["rcb"],
      Package["nova-common"],
      Package["python-xattr"],
      User["glance"]
    ]
  }

  file { "glance-api.conf":
    path => "/etc/glance/glance-api.conf",
    ensure  => present,
    owner   => "glance",
    mode    => 0600,
    content => template("glance/glance-api.conf.erb"),
    notify => Service["glance-api"],
    require => Package["glance"]
  }

  file { "/var/log/glance":
    ensure => directory,
    owner  => "glance",
    mode   => 0755,
    require => [Package["glance"], Package["python-glance"]]
  }

  file { "/var/log/glance/api.log":
    ensure => present,
    owner  => "glance",
    mode   => 0600,
    require => File["/var/log/glance"]
  }

  file { "/usr/local/bin/keyglance":
    ensure  => present,
    owner   => 'glance',
    group   => 'glance',
    mode    => 0755,
    content => template('glance/keyglance.erb'),
  }
}

