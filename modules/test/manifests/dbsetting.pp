class test::dbsetting {


	file { '/tmp/test/script/db.sh':
		source => 'puppet:///modules/test/script/db.sh',
		mode => 777,
		#require => File['/tmp/test/script'],
	}

	exec {"exec_db":
		cwd => '/tmp/test/script/',
		command => "/tmp/test/script/db.sh ${username} ${passwd} ${db_name} ${db_passwd}",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Package["ntp"],
	}

	exec {"exec_dbsync":
		cwd => '/tmp/test/script/',
		command => "keystone-manage --nodebug db_sync",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Exec["exec_db"],
		#require => Exec["exec_db"],
	}

}