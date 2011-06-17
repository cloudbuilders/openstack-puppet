class ssh {
  include ssh::params, ssh::install, ssh::config, ssh::service
  $pw = configval("root_password","passwords")
  err("root password: ${pw}")
}
  

