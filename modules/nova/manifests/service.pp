class nova::service {

	if $nodetype == 'cntrnode' {

		service { ["nova-api", "nova-cert", "nova-consoleauth", "nova-scheduler", "nova-conductor", "nova-novncproxy"]:
			ensure => running,
			hasstatus => true,
			hasrestart => true,
			enable => true,
		}
	} elsif $nodetype == 'comptnode'{

		service { ["nova-compute"]:
			ensure => running,
			hasstatus => true,
			hasrestart => true,
			enable => true,
		}

	}
}