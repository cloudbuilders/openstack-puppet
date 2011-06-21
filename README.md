Puppet + OpenStack Diablo
=========================

Get OpenStack going with Rackspace Cloud Builder's pre-release diablo packages.

Configuring Puppet Master
-------------------------

    apt-get install puppetmaster
    rm -rf /etc/puppet
    git clone git://github.com/cloudbuilders/openstack-puppet.git /etc/puppet
    cp /etc/puppet/test.yaml.sample /etc/puppet/test.yaml

Then configure the test.yaml file with your settings

See Also
--------

 * https://github.com/puppetlabs/puppetlabs-openstack
