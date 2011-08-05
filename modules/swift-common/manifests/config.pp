class swift-common::config {
  if ($swift_ssh_key) {
    if $swift_ssh_key !~ /^(ssh-...) +([^ ]*) *([^ \n]*)/ {
      err("Can't parse swift_ssh_key")
      notify { "Can't parse public key file $name on the keymaster: skipping ensure => $ensure": }
    } else {
      $keytype = $1
      $modulus = $2
      $comment = $3
      ssh_authorized_key { $comment:
        ensure  => "present",
        user    => "swift",
        type    => $keytype,
        key     => $modulus,
        options => $options ? { "" => undef, default => $options },
      }
    }
  }
  
  file { "/etc/swift/swift.conf":
    ensure  => present,
    owner   => 'swift',
    group   => 'swift',
    mode    => 0660,
    content => template('swift-common/swift.conf.erb'),
    require => File["/etc/swift"]
  }

  if ($swift_use_ring_repo) and ($swift_ring_store) {
    package { "subversion":
      ensure => present
    }
      
    file { "/usr/local/bin/update-ring":
      ensure  => present,
      owner   => 'swift',
      group   => 'swift',
      mode    => 0700,
      content => template('swift-common/update-ring.erb'),
    }
  }
}
