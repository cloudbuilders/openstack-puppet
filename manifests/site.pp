# Site config
import "classes/*"
import "sitedefs.pp"

# These are the variables that must be set if not using an
# external node classifier
#
# 
# $flat_interface = "eth0"
# $use_keystone = true
# $use_ipv6 = false
# $use_glance = true
# $network_manager = "FlatDHCPManager"
# $libvirt_type = "qemu"
# $fixed_range = "10.0.0.0/24"
# $floating_range = "10.0.1.0/24"
# $nova_admin_username = "changeme"
# $nova_admin_password = "changeme"
# $mysql_nova_password = "changeme"
# $mysql_root_password = "changeme"
# $root_password = "changeme"
# $root_authorized_keys = "ssh-dss AAAAymWIgnie.....Xdw== foo@foo.bar.org"
# $mysql_vip = "MYSQL_IP - changeme"
# $api_vip = "API_IP - changeme"
# $rabbitmq_vip = "RABBIT_IP - changeme"
#

# TODO: (rp)
# external node classifier based on cluster yaml file
node default {
  include nova-infra-node
  include nova-compute-node
}
