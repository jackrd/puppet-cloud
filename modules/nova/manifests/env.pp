class nova::env {
	
	include nova::params

	file { '/tmp/nova/':
		ensure => directory,
	}

	file { '/tmp/nova/env/':
		ensure => directory,
	}
	
	file { '/tmp/nova/env/novarc.sh':
		ensure => present,
		content => template("nova/env/novarc.sh.erb"),
		mode => 777,
	}
	
}