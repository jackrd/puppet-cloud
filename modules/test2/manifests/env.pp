class test2::env {
	
	include test2::params
	
	file { '/tmp/test':
		ensure => directory,
	}

	file { '/tmp/test/env':
		ensure => directory,
	}

	file { "/tmp/test/env/ww.sh":
		ensure => present,
		content => template("test2/env/ww.sh.erb"),
		mode => 777,
	}
	
}