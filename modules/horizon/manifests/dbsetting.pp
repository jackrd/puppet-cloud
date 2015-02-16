class horizon::dbsetting {

	file { '/tmp/horizon/db.sh':
		source => 'puppet:///modules/horizon/script/db.sh',
		mode => 777,
		require => File['/tmp/horizon/'],
	}

	exec {"exec_db":
		cwd => '/tmp/horizon/',
		command => "/tmp/horizon/db.sh ${username} ${passwd} ${db_name} ${db_passwd}",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Package["horizon"],
	}

	exec {"exec_dbsync":
		cwd => '/tmp/horizon/',
		command => "horizon-manage --nodebug db_sync",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Exec["exec_db"],
	}

}