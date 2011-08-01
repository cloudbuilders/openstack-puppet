class mysql::install {
  if $use_ha {
    require 'drbd'
  }

  group { 'mysql':
    ensure  => present,
    gid     => 503
  }
  
  user { 'mysql':
    ensure  => present,
    uid     => 503,
    gid     => 'mysql',
    home    => '/nonexistent',
    shell   => '/bin/false',
    require => Group['mysql']
  }
    
  preseed_package { "mysql-server":
    ensure => present,
    source => "mysql/mysql-preseed.erb"
  }
}
  
