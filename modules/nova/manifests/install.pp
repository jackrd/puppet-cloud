class nova::install {
	
	if $::nodetype == 'controller' {
		package { ["nova-api", "nova-cert", "nova-consoleauth", "nova-scheduler", "nova-conduct", "nova-novncproxy", "python-novaclient"]:
			ensure => installed,
		}
	} else {
		package { ["nova-compute-kvm", "python-guestfs"]:
			ensure => installed,
		}
	}
}