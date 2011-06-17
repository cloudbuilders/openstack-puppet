class mysql::install {
  $password_hash = configval("passwords", $cluster_name)
  $mysql_password = $password_hash["mysql_root_password"]
  
  preseed_package { "mysql-server":
    ensure => present,
    source => "mysql/mysql-preseed.erb"
  }
}
  
