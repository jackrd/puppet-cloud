class glance::env {
	
	include glance::params

	file { '/tmp/glance/':
		ensure => directory,
	}
	
	file { '/tmp/glance/env':
		ensure => directory,
	}

	file { '/tmp/glance/env/glancerc.sh':
		ensure => present,
		content => template("glance/env/glancerc.sh.erb"),
		mode => 777,
	}
	
	
}