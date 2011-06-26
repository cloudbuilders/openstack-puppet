class cloudkick {

  exec { "cloudkick_aptkey":
    path => "/bin:/usr/bin",
    command => "curl http://packages.cloudkick.com/cloudkick.packages.key | apt-key add -",
    unless => "apt-key list | grep -q Cloudkick"
  }
  
  apt::source { "cloudkick":
    location => "http://packages.cloudkick.com/ubuntu",
    release => "maverick",
    repos => "main",
    require => [
      Exec["cloudkick_aptkey"]
    ]
  }
  
  file {
    # '/usr/lib/cloudkick-agent':
    #   ensure => directory;
           
    # cloudkick-plugins:
    #   path => "/usr/lib/cloudkick-agent/plugins/",
    #   recurse => true,
    #   require => File['/usr/lib/cloudkick-agent'],
    #   source => "puppet://$server/generic/cloudkick/plugins/";
 
    "/etc/cloudkick.conf":
      content => template("cloudkick/cloudkick.conf.erb");
  }
  
  package { 'cloudkick-agent':
    ensure => latest,
    require => [
      Apt::Source["cloudkick"],
      File["/etc/cloudkick.conf"]
    ]
  }

  service { "cloudkick-agent":
    enable => true,
    ensure => running,
    require => File["/etc/cloudkick.conf"];
  }
}
