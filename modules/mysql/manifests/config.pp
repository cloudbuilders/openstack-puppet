class mysql::config {
  file { '/etc/mysql':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => 0755
  }
    
  file { '/etc/mysql/my.cnf':
    ensure  => present,
    require => [ File['/etc/mysql'], Class['mysql::install'] ],
    owner   => root,
    group   => root,
    mode    => 0644,
    content => template('mysql/my.cnf.erb'),
    notify  => Service['mysql']
  }
}
  
