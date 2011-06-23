#!/bin/bash

# Tenants
keystone-manage $* tenant add admin
keystone-manage $* tenant add demo

# Users
keystone-manage $* user add demo secrete demo
keystone-manage $* user add admin secrete admin

# Roles
keystone-manage $* role add Admin

#endpointTemplates
keystone-manage $* endpointTemplates add RegionOne swift http://swift.publicinternets.com/v1/AUTH_%tenant_id% http://swift.admin-nets.local:8080/ http://127.0.0.1:8080/v1/AUTH_%tenant_id% 1
keystone-manage $* endpointTemplates add RegionOne nova_compat http://nova.publicinternets.com/v1.0/ http://127.0.0.1:8774/v1.0  http://localhost:8774/v1.0 1
keystone-manage $* endpointTemplates add RegionOne nova http://nova.publicinternets.com/v1.1/ http://127.0.0.1:8774/v1.1  http://localhost:8774/v1.1 1
keystone-manage $* endpointTemplates add RegionOne glance http://glance.publicinternets.com/v1.1/%tenant_id% http://nova.admin-nets.local/v1.1/%tenant_id% http://127.0.0.1:9292/v1.1/%tenant_id% 1
keystone-manage $* endpointTemplates add RegionOne keystone http://keystone.publicinternets.com/v2.0 http://127.0.0.1:8081/v2.0 http://127.0.0.1:8080/v2.0 1

# Tokens
keystone-manage $* token add 999888777666 admin 1234 2015-02-05T00:00

#Tenant endpoints
keystone-manage $* endpoint add 1234 1
keystone-manage $* endpoint add 1234 2
keystone-manage $* endpoint add 1234 3
keystone-manage $* endpoint add 1234 4
keystone-manage $* endpoint add 1234 5
