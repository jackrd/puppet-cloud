class neutron::install {


	if $nodetype == 'cntrnode' {

		package { ["neutron-server"]:
			ensure => installed,
		}
		package { ["neutron-plugin-ml2"]:
			ensure => installed,
		}


	} elsif $nodetype == 'comptnode' {

		package { ["neutron-common", "neutron-plugin-ml2", "neutron-plugin-openvswitch-agent","openvswitch-switch"]:
			ensure => installed,
		}

	} elsif $nodetype == 'networknode' {

		package { ["neutron-plugin-openvswitch-agent","openvswitch-switch", "neutron-plugin-ml2","neutron-l3-agent", "neutron-dhcp-agent"]:
			ensure => installed,
		}
	}
}