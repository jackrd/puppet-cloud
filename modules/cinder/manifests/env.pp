class cinder::env inherits cinder {
	
	include cinder::params

	file { '/tmp/cinder/':
		ensure => directory,
	}

	file { '/tmp/cinder/env/':
		ensure => directory,
	}

	file { '/tmp/cinder/env/cinderrc.sh':
		ensure => present,
		content => template("cinder/env/cinderrc.sh.erb"),
		mode => 777,
	}
}