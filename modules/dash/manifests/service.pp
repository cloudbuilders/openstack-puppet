class dash::service {
  service { "apache2":
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Class["dash::install"],
    subscribe => [
      File["local_settings.py"],
      File["django.wsgi"],
      File["apache-site"]
    ]
  }
}
