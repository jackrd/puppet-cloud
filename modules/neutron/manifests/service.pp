class neutron::service {


	if $nodetype == 'cntrnode' {

		service { ["neutron-server",]:
			ensure => running,
			hasstatus => true,
			hasrestart => true,
			enable => true,
		}

	} elsif $nodetype == 'comptnode' {

		service { ["neutron-plugin-openvswitch-agent","openvswitch-switch"]:
			ensure => running,
			hasstatus => true,
			hasrestart => true,
			enable => true,
		}


	} elsif $nodetype == 'networknode' {

		service { ["neutron-plugin-openvswitch-agent","neutron-l3-agent", "neutron-dhcp-agent", "neutron-metadata-agent"]:
			ensure => running,
			hasstatus => true,
			hasrestart => true,
			enable => true,
		}

	}

	
}