class glance::env {
	
	include glance::params

	file { '/tmp/glance/':
		ensure => directory,
	}
	
}