class keystone::config inherits keystone{


	file { '/tmp/keystone/keystone.sh':
		source => 'puppet:///modules/keystone/script/keystone.sh',
		mode => 777,
		require => File['/tmp/keystone/'],
	}

	exec { "exec_keystone":
		command => "bash -c '/tmp/keystone/keystone.sh'",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => File["/tmp/keystone/keystone.sh"],
		notify => Class["keystone::service"],
	}

	file { '/tmp/keystone/keystone_post.sh':
		source => 'puppet:///modules/keystone/script/keystone_post.sh',
		mode => 777,
		require => File['/tmp/keystone/'],
	}

	exec { "exec_keystone_post":
		environment => ["OS_SERVICE_TOKEN=${os_service_token}", "OS_SERVICE_ENDPOINT=${os_service_endpoint}"],
		command => "bash -c '/tmp/keystone/keystone_post.sh ${nodetype} ${aDMIN_PASS} ${aDMIN_EMAIL}'",
		path => ["/bin/","/usr/bin/"],
		require => [Package['keystone'],Service["keystone"]],
		refreshonly => true,
		subscribe => Service["keystone"],
	}

}
