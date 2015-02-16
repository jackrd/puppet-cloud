class cinder::env {
	
	include cinder::params

	file { '/tmp/cntr/':
		ensure => directory,
	}

	file { '/tmp/cntr/cinder/':
		ensure => directory,
	}
	
}