class swift-storage::install {
  require "swift-common"

  $swift_storage_packages = [ "swift-account", "swift-container",
                              "swift-object" ]
  $swift_storage_extra = [ "xfsprogs", "parted", "rsync" ]

  package { $swift_storage_packages:
    ensure => present
  }

  package { $swift_storage_extra:
    ensure => present
  }
}
