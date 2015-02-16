class swift::dbsetting {

	file { '/tmp/swift/db.sh':
		source => 'puppet:///modules/swift/script/db.sh',
		mode => 777,
		require => File['/tmp/swift/'],
	}

	exec {"exec_db":
		cwd => '/tmp/swift/',
		command => "/tmp/swift/db.sh ${username} ${passwd} ${db_name} ${db_passwd}",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Package["swift"],
	}

	exec {"exec_dbsync":
		cwd => '/tmp/swift/',
		command => "swift-manage --nodebug db_sync",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Exec["exec_db"],
	}

}