class users::install {
    # Create RCB group
    group { "rcb":
        ensure => present,
        gid     => 901,
    }

    # Create users
    create_user { "dtroyer":
        uid     => 1001,
        email   => "dean.troyer@rackspace.com",
        keyfiles => [ "dtroyer-sweetums.pub", "dtroyer-beaker.pub" ]
    }

    create_user { "vishvananda":
        uid     => 1002,
        email   => "vish.ishaya@rackspace.com",
        keyfiles => [ "vishvananda-argent.pub", "vishvananda-firefly.pub" ]
    }

    create_user { "jesse":
        uid     => 1003,
        email   => "jesse.andrews@rackspace.com",
        keyfiles => [ "jesse-spacey.pub" ]
    }

    create_user { "chmouel":
           uid     => 1004,
           email   => "chmouel.boudjnah@rackspace.co.uk",
           keyfiles => [ "chmouel.pub" ]
     }

    # Put pubkey files in place
    define user_keys {
        $key_content = file("/etc/puppet/modules/users/files/$name", "/dev/null")
        if ! $key_content {
            notify { "Public key file $name not found on keymaster; skipping ensure => present": }
        } else {
            if $key_content !~ /^(ssh-...) +([^ ]*) *([^ \n]*)/ {
                err("Can't parse public key file $name")
                notify { "Can't parse public key file $name on the keymaster: skipping ensure => $ensure": }
            } else {
                $keytype = $1
                $modulus = $2
                $comment = $3
                ssh_authorized_key { $comment:
                    ensure  => "present",
                    user    => $username,
                    type    => $keytype,
                    key     => $modulus,
                    options => $options ? { "" => undef, default => $options },
                }
            }
        }
    } # user_keys

    # Create user accounts
    define create_user($uid, $email, $keyfiles) {
        $username = $title

        user { $username:
            ensure      => present,
            uid         => $uid,
            comment     => $email,
            home        => "/home/$username",
            shell       => "/bin/bash",
            managehome  => true,
            groups      => "rcb",
        }

        group { $username:
            gid         => $uid,
            require     => User[$username]
        }

        file { "/home/$username/":
            ensure      => directory,
            owner       => $username,
            group       => $username,
            mode        => 750,
            require     => [ User[$username], Group[$username] ]
        }

        file { "/home/$username/.ssh":
            ensure      => directory,
            owner       => $username,
            group       => $username,
            mode        => 700,
            require     => File["/home/$username/"]
        }

        user_keys { $keyfiles: }
    } # create_user



}
