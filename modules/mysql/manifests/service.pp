class mysql::service {
  
  if $use_ha {
    if ! $ha_primary {
      $ensure_value = stopped
      $enable_value = false
    } else {
      $ensure_value = running
      $enable_value = true
    }
  } else {
    $ensure_value = running
    $enable_value = true
  }
  
  service { "mysql":
    ensure => $ensure_value,
    enable => $enable_value,
    require => Class["mysql::config"]
  }
}
