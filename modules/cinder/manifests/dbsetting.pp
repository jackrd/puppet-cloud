class cinder::dbsetting {

	file { '/tmp/cinder/db.sh':
		source => 'puppet:///modules/cinder/script/db.sh',
		mode => 777,
		require => File['/tmp/cinder/'],
	}

	exec {"exec_db":
		cwd => '/tmp/cinder/',
		command => "/tmp/cinder/db.sh ${username} ${passwd} ${db_name} ${db_passwd}",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Package["cinder"],
	}

	exec {"exec_dbsync":
		cwd => '/tmp/cinder/',
		command => "cinder-manage --nodebug db_sync",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Exec["exec_db"],
	}

}