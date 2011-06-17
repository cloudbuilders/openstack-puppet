
class ssh::install {
  package { "ssh":
    name   => $ssh::params::ssh_package_name,
    ensure => present
  }
}
