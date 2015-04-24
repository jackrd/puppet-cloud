class nova::install inherits nova{
	
	if $nodetype == 'cntrnode' {

		package { ["nova-api", "nova-cert", "nova-consoleauth", "nova-scheduler", "nova-conductor", "nova-novncproxy", "python-novaclient"]:
			ensure => installed,
		}
	} elsif $nodetype == 'comptnode'{

		package { ["nova-compute-kvm"]:
			ensure => installed,
		}
	}
}