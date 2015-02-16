#************************************************************************************
#    Copyright(C) 2014-2015 Inventec Corporation. All rights reserved.
#************************************************************************************
#!/bin/bash

#####################################################################################
# Source the setup file to read in the environment variables

source /tmp/setuprc.sh

# Configuration File
SWIFT_CONF=/etc/swift/swift.conf
MEMCACHED_CONF=/etc/memcached.conf
SWIFT_PROXY_SERVER_CONF=/etc/swift/proxy-server.conf


#####################################################################################
# Create the configuration directory on all nodes

# Create /etc/swift/swift.conf on all nodes
echo "
[swift-hash]
# random unique string that can never change (DO NOT LOSE)
swift_hash_path_prefix = xrfuniounenqjnw
swift_hash_path_suffix = fLIbertYgibbitZ
" > $SWIFT_CONF


#####################################################################################
# Install and configure the proxy node
# 2. Modify memcached to listen on the default interface on a local, non-public network.
# Edit this line in the /etc/memcached.conf file
sed -i "
/^-l 127.0.0.1.*$/s/^.*$/-l $MGMT_NETIP_CONTROLLER/
" $MEMCACHED_CONF

# 4. Create /etc/swift/proxy-server.conf
# Note: Only the proxy server uses memcache
echo "
[DEFAULT]
bind_port = 8080
user = swift

[pipeline:main]
pipeline = healthcheck cache authtoken keystoneauth proxy-server

[app:proxy-server]
use = egg:swift#proxy
allow_account_management = true
account_autocreate = true

[filter:keystoneauth]
use = egg:swift#keystoneauth
operator_roles = Member,admin,swiftoperator

[filter:authtoken]
paste.filter_factory = keystoneclient.middleware.auth_token:filter_factory

# Delaying the auth decision is required to support token-less
# usage for anonymous referrers ('.r:*').
delay_auth_decision = true

# auth_* settings refer to the Keystone server
auth_protocol = http
auth_host = controller
auth_port = 35357

# the service tenant and swift username and password created in Keystone
admin_tenant_name = service
admin_user = swift
admin_password = $SWIFT_PASS

[filter:cache]
use = egg:swift#memcache

[filter:catch_errors]
use = egg:swift#catch_errors

[filter:healthcheck]
use = egg:swift#healthcheck
" > $SWIFT_PROXY_SERVER_CONF




