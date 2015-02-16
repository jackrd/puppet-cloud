class neutron::install {
	package { ["neutron-server", "neutron-plugin-ml2"]:
		ensure => installed,
	}

}