#!/usr/bin/env python

import json
import os
import re
import sys
import urllib2

# default kick options, override in /etc/puppet/enc.yaml
#
config = {
    'kick_uri':  'http://<bleep server>:<bleep port>',
    'kick_user': '<admin user>',
    'kick_pass': '<admin pass>'
}

with open('/etc/puppet/enc.yaml') as f:
    yaml_config = json.load(f)
    config.update(yaml_config)

# got the config... fetch kick info from os-kick.

hardware_uri = config['kick_uri'] + '/admin/hardware/view'

auth_handler = urllib2.HTTPBasicAuthHandler()
auth_handler.add_password(realm = 'kick dingus',
                          uri = config['kick_uri'],
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

hostname = sys.argv[1].split('.')[0]

machine_info = [x for x in oskick_details['hardware'] if x['hostname'].split('.')[0] == hostname ]
if not machine_info:
    print "Can't find machine info"
    sys.exit(1)
    
cluster_id = machine_info[0]['cluster_id']

# now, pull the short name of the cluster

cluster_uri = config['kick_uri'] + '/admin/clusters/view/%s' % cluster_id
req = urllib2.Request(cluster_uri, None, { 'Accept': 'application/json' })

cluster_name = 'test'

try:
    r = urllib2.urlopen(req)
    cluster_name = json.load(r)['short_name']
except urllib2.URLError, e:
    if e.code != 404:
        sys.exit(1)

# print oskick_details

cluster_details = {}

try:
    cluster_description = '/etc/puppet/%s.yaml' % cluster_name
    fd = open(cluster_description)
except Exception as e:
    print 'Error opening %s' % cluster_description
    print e
    sys.exit(1)

cluster_details = json.load(fd)
fd.close()

# walk through the cluster config, find all matches for
# each role.

roles_by_machine = {}
machines_by_role = {}

for role, rolematch in cluster_details['cluster'].items():
    for hwinfo in oskick_details['hardware']:
        host = hwinfo['hostname'].split('.')[0]

        if host and re.match(rolematch, host):
            if not roles_by_machine.has_key(host):
                roles_by_machine[host] = []
            roles_by_machine[host].append(role)

            if not machines_by_role.has_key(role):
                machines_by_role[role] = []

            if host not in machines_by_role[role]:
                machines_by_role[role].append(host)
            
# Now generate the roles list
enc_manifest = { 'classes': [], 'parameters': {} }

#print "looking for roles for %s" % hostname

if not roles_by_machine.has_key(hostname):
    # not found..
    print "No roles!"
    sys.exit(1)

for role in roles_by_machine[hostname]:
    enc_manifest['classes'].append(role)

for key, value in cluster_details['options'].items():
    new_value = value

    matchgroup = re.match("#\{(.*)\}", str(value))
    if matchgroup:
        # return the ip of the node (or first match)
        matching_host = [ x['ip_address'] for x in oskick_details['hardware']
                          if re.match(matchgroup.group(1),x['hostname'].split('.')[0]) ]
        if matching_host:
            new_value = matching_host[0]

    matchgroup = re.match('@\{(.*)\}', str(value))
    if matchgroup:
        # return an array of matching ips
        pass

    enc_manifest['parameters'][key] = new_value

print json.dumps(enc_manifest, indent=2)


