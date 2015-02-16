class neutron::service {
	service { ["neutron-server",]:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		#require => Class["neutron::config"],
	}
}