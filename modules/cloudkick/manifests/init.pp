class cloudkick {
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
    require => File["/etc/cloudkick.conf"];
  }

  service { "cloudkick-agent":
    enable => true,
    ensure => running,
    require => File["/etc/cloudkick.conf"];
  }
}
