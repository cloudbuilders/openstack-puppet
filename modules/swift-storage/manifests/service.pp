class swift-storage::service {
  require "swift-storage::config"

  service { "rsync":
    ensure => running,
    enable => true
  }

  # all these services require rings!
  
  # object server services
  $swift_object_server_services = [ "swift-object", "swift-object-replicator",
                                    "swift-object-auditor", "swift-object-updater" ]
  service { $swift_object_server_services:
    ensure    => running,
    enable    => true,
    hasstatus => true
  }

  # account services
  $swift_account_server_services = [ "swift-account", "swift-account-replicator",
                                     "swift-account-auditor", "swift-account-reaper" ]
  service { $swift_account_server_services:
    ensure    => running,
    enable    => true,
    hasstatus => true
  }

  # container services
  $swift_container_server_services = [ "swift-container", "swift-container-replicator",
                                       "swift-container-auditor", "swift-container-updater" ]
  service { $swift_container_server_services:
    ensure    => running,
    enable    => true,
    hasstatus => true
  }
}
  
