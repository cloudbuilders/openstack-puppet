# roughly stolen from puppet wiki:
# http://projects.puppetlabs.com/projects/1/wiki/Debian_Preseed_Patterns
#
# We'll require a source, though, and expect that source to be
# templated
#
define preseed_package ( $ensure, $source ) {
  file { "/var/local/preseed":
    ensure => directory,
    owner  => "root",
    group  => "root",
    mode   => 0700
  }
    
  file { "/var/local/preseed/$name.preseed":
    content => template($source),
    mode    => 0600,
    backup  => false,
    require => File["/var/local/preseed"]
  }
  
  package { "$name":
    ensure       => $ensure,
    responsefile => "/var/local/preseed/$name.preseed",
    require      => File["/var/local/preseed/$name.preseed"],
  }
}
