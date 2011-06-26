class cloudkick {

  exec { "cloudkick_aptkey":
    path => "/bin:/usr/bin",
    command => "curl http://packages.cloudkick.com/cloudkick.packages.key | apt-key add -",
    unless => "apt-key list | grep -q Cloudkick"
  }
  
  exec { "cloudkick_apt":
    path => "/bin:/usr/bin",
    command => "echo 'deb http://packages.cloudkick.com/ubuntu maverick main' > /etc/apt/sources.list.d/cloudkick.list; apt-get update",
    unless => "test -f /etc/apt/sources.list.d/cloudkick.list",
    require => Exec["cloudkick_aptkey"]
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
      Exec["cloudkick_apt"],
      File["/etc/cloudkick.conf"]
    ]
  }

  service { "cloudkick-agent":
    enable => true,
    ensure => running,
    subscribe => File["/etc/cloudkick.conf"],
    require => Package["cloudkick-agent"]
  }
}
