class keystone::env {
	
	include keystone::params

	file { '/tmp/keystone/':
		ensure => directory,
	}

}