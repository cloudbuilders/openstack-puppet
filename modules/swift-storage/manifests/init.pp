# This should be split into object, account and container at some point

class swift-storage {
  require "swift-common"
  
  include swift-storage::install, swift-storage::config, swift-storage::service
}
