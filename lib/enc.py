#!/usr/bin/env python

import json
import re
import sys
import urllib2

# default kick options, override in /etc/puppet/enc.yaml
#
config = {
    'kick_uri':  'http://192.168.122.2:5000',
    'kick_user': 'admin',
    'kick_pass': 'supersecret'
    }

with open('/etc/puppet/enc.yaml') as f:
    yaml_config = json.load(f)
    config.update(yaml_config)

# got the config... fetch kick info from os-kick.

hardware_uri = config['kick_uri'] + '/admin/hardware/view'

auth_handler = urllib2.HTTPBasicAuthHandler()
auth_handler.add_password(realm = 'kick dingus',
                          uri = hardware_uri,
                          user = config['kick_user'],
                          passwd = config['kick_pass'])
                          
opener = urllib2.build_opener(auth_handler)
urllib2.install_opener(opener)

req = urllib2.Request(hardware_uri, None, { 'Accept': 'application/json' })
r = urllib2.urlopen(req)

oskick_details = json.load(r)

# we should pull cluster name (and hence yaml file) from
# the oskick data, but we don't have multi-tenant support
# there yet, so we'll dummy it up

cluster_name = 'test'

cluster_details = {}

with open('/etc/puppet/%s.yaml' % cluster_name) as f:
    cluster_details = json.load(f)


# walk through the cluster config, find all matches for
# each role.

roles_by_machine = {}
machines_by_role = {}

for role, rolematch in cluster_details['cluster'].items():
    for hwinfo in oskick_details['hardware']:
        hostname = hwinfo['hostname']
        
        if hostname and re.match(rolematch, hostname):
            if not roles_by_machine.has_key(hostname):
                roles_by_machine[hostname] = []
            roles_by_machine[hostname].append(role)

            if not machines_by_role.has_key(role):
                machines_by_role[role] = []

            if hostname not in machines_by_role[role]:
                machines_by_role[role].append(hostname)
            
# Now generate the roles list
enc_manifest = { 'classes': [], 'parameters': {} }

hostname = sys.argv[1] #.split('.')[0]

if not roles_by_machine.has_key(hostname):
    # not found..
    sys.exit(1)

for role in roles_by_machine[hostname]:
    enc_manifest['classes'].append(role)

for key, value in cluster_details['options'].items():
    new_value = value

    matchgroup = re.match("#\{(.*)\}", str(value))
    if matchgroup:
        # return the ip of the node (or first match)
        matching_host = [ x['ip_address'] for x in oskick_details['hardware']
                          if re.match(matchgroup.group(1),x['hostname']) ]
        if matching_host:
            new_value = matching_host[0]

    matchgroup = re.match('@\{(.*)\}', str(value))
    if matchgroup:
        # return an array of matching ips
        pass

    enc_manifest['parameters'][key] = new_value

print json.dumps(enc_manifest, indent=2)


