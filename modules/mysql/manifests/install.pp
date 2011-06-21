class mysql::install {
  preseed_package { "mysql-server":
    ensure => present,
    source => "mysql/mysql-preseed.erb"
  }
}
  
