class mysql::server {
  include mysql::install, mysql::config, mysql::service
}
