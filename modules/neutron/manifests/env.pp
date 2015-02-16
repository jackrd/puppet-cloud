class neutron::env {
	
	include neutron::params

	file { '/tmp/cntr/':
		ensure => directory,
	}

	file { '/tmp/cntr/neutron/':
		ensure => directory,
	}
	
}