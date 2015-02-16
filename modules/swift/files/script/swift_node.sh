#************************************************************************************
#    Copyright(C) 2014-2015 Inventec Corporation. All rights reserved.
#************************************************************************************
#!/bin/bash

#####################################################################################
# Source the setup file to read in the environment variables
source /tmp/env/setuprc.sh

# Configuration File
SWIFT_CONF=/etc/swift/swift.conf
RSYNCD_CONF=/etc/rsyncd.conf

#####################################################################################
# Create the configuration directory on all nodes
# Create /etc/swift/swift.conf on all nodes
echo "
[swift-hash]
# random unique string that can never change (DO NOT LOSE)
swift_hash_path_prefix = xrfuniounenqjnw
swift_hash_path_suffix = fLIbertYgibbitZ
" > $SWIFT_CONF


# 2. For each device on the node that you want to use for storage, set up the XFS volume
# Use a single partition per drive
#read -p "Ender the device that you want it to be the storage(ex: sdb):" XFS_Dev

#for ((i = 0; i < ${#XFS_Dev_Array[@]}; i++))
#do
#    XFS_Dev=${XFS_Dev_Array[$i]}
#
#    mkfs.xfs /dev/$XFS_Dev
#    echo "/dev/$XFS_Dev /srv/node/$XFS_Dev xfs noatime,nodiratime,nobarrier,logbufs=8 0 0" >> /etc/fstab
#    mkdir -p /srv/node/$XFS_Dev
#    mount /srv/node/$XFS_Dev
#    chown -R swift:swift /srv/node
#done

# Copied to the backup before editing

# 3. Create /etc/rsyncd.conf
echo "
uid = swift
gid = swift
log file = /var/log/rsyncd.log
pid file = /var/run/rsyncd.pid
address = $MGMT_NETIP_OBJECT1

[account]
max connections = 2
path = /srv/node/
read only = false
lock file = /var/lock/account.lock

[container]
max connections = 2
path = /srv/node/
read only = false
lock file = /var/lock/container.lock

[object]
max connections = 2
path = /srv/node/
read only = false
lock file = /var/lock/object.lock
" > $RSYNCD_CONF

# 4. (Optional) If you want to separate rsync and replication traffic to replication network,
# set MGMT_NETIP_OBJECT1 instead of MGMT_NETIP_OBJECT1
sed -i "
/^address =.*$/s/^.*$/address = $MGMT_NETIP_OBJECT1/
" $RSYNCD_CONF

# 5. Edit the following line in /etc/default/rsync
sed -i "
/^RSYNC_ENABLE=.*$/s/^.*$/RSYNC_ENABLE=true/
" /etc/default/rsync

exit 0