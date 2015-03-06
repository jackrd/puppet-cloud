class keystone::dbsetting {

	file { '/tmp/keystone/db.sh':
		source => 'puppet:///modules/keystone/script/db.sh',
		mode => 777,
		require => File['/tmp/keystone/'],
	}

	exec {"exec_keystone_db":
		cwd => '/tmp/keystone/',
		command => "/tmp/keystone/db.sh ${username} ${passwd} ${keystone_db_name} ${keystone_db_passwd}",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => [ Package["keystone"],File["/tmp/keystone/db.sh"] ],
	}

	exec {"exec_keystone_dbsync":
		cwd => '/tmp/keystone/',
		command => "keystone-manage --nodebug db_sync",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Exec["exec_keystone_db"],
	}

}