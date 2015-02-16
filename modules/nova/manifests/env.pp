class nova::env {
	
	include nova::params

	file { '/tmp/cntr/':
		ensure => directory,
	}

	file { '/tmp/cntr/nova/':
		ensure => directory,
	}
	
}