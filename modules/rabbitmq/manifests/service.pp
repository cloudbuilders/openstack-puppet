class rabbitmq::service {
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

  service { "rabbitmq-server":
    ensure    => $ensure_value,
    enable    => $enable_value,
    hasstatus => true,
    require   => Class['rabbitmq::install']
  }
}
