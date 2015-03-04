class keystone::env {
	
	include keystone::params

	file { '/tmp/keystone/':
		ensure => directory,
	}

	file { '/tmp/keystone/env/':
		ensure => directory,
	}

	file { '/tmp/keystone/env/keystonerc.sh':
		ensure => present,
		content => template("keystone/env/keystonerc.sh.erb"),
		mode => 777,
	}
}