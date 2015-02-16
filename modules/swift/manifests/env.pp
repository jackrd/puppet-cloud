class swift::env {
	
	include swift::params

	file { '/tmp/swift/':
		ensure => directory,
	}
	
}