class ssh::params {
  case $operatingsystem {
    /(Ubuntu|Debian)/: {
      $ssh_package_name = "openssh-server"
    }

    default: {
      $ssh_package_name = "sshd"
    }
  }
}
