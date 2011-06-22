
class sudoers::install {
  package { "sudo":
    name   => "sudo",
    ensure => present
  }
}
