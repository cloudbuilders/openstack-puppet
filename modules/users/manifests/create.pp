class users::create {

    # Create RCB group
    group { "rcb":
        ensure => present,
        gid     => 901,
    }

    # Create users
    create_user { "dtroyer":
        uid     => 1001,
        email   => "dean.troyer@rackspace.com",
        keyfiles => [ "dtroyer-sweetums.pub", "dtroyer-drteeth.pub" ]
    }
}
