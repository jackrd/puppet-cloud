class keystone::config {


	file { '/tmp/keystone/keystone.sh':
		source => 'puppet://puppet/modules/keystone/script/keystone.sh',
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
		source => 'puppet://puppet/modules/keystone/script/keystone_post.sh',
		mode => 777,
		require => File['/tmp/keystone/'],
	}

	exec { "exec_keystone_post":
		command => "bash -c '/tmp/keystone/keystone_post.sh ${nodetype}'",
		path => ["/bin/","/usr/bin/"],
		require => Service['keystone'],
		refreshonly => true,
		subscribe => Package['keystone'],
	}

}