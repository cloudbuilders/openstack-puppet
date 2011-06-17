class nova-db {
  # this should be split into nova-db::master, nova-db::slave with drbd
  # NO!  mysql should be.. this should be independant
  include nova-common
  include mysql::server
  include nova-db::install
}
