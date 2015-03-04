class test::dbsetting {


	file { '/tmp/test/script/db.sh':
		source => 'puppet:///modules/test/script/db.sh',
		mode => 777,
		#require => File['/tmp/test/script'],
	}

	exec {"exec_db_test":
		cwd => '/tmp/test/script/',
		command => "/tmp/test/script/db.sh ${username} ${passwd} ${db_name} ${db_passwd}",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => [ Package["ntp"], File["/tmp/test/script/db.sh"] ],
	}

	exec {"exec_dbsync_test":
		cwd => '/tmp/test/script/',
		command => "keystone-manage --nodebug db_sync",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Exec["exec_db_test"],
		#require => Exec["exec_db"],
	}

}