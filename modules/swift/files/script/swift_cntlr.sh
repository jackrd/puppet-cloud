#************************************************************************************
#    Copyright(C) 2014-2015 Inventec Corporation. All rights reserved.
#************************************************************************************
#!/bin/bash

#####################################################################################
# Source the setup file to read in the environment variables
source /tmp/setuprc.sh

# Configuration File
SWIFT_CONF=/etc/swift/swift.conf

#####################################################################################
# General installation steps

# 5. Create /etc/swift/swift.conf on all nodes
# Note: The prefix and suffix value in /etc/swift/swift.conf should be set to some
# random string of text to be used as a salt when hashing to determine mappings in the ring
echo "
[swift-hash]
# random unique string that can never change (DO NOT LOSE)
swift_hash_path_prefix = xrfuniounenqjnw
swift_hash_path_suffix = fLIbertYgibbitZ
" > $SWIFT_CONF

