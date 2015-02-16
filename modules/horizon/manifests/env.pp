class horizon::env {
	
	include horizon::params

	file { '/tmp/horizon/':
		ensure => directory,
	}
	
}