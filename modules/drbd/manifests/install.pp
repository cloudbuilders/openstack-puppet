class drbd::install {
  package { 'drbd8-utils':
    ensure => installed
  }
}

