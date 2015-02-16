class glance::dbsetting {

	file { '/tmp/glance/db.sh':
		source => 'puppet:///modules/glance/script/db.sh',
		mode => 777,
		require => File['/tmp/glance/'],
	}

	exec {"exec_db":
		cwd => '/tmp/glance/',
		command => "/tmp/glance/db.sh ${username} ${passwd} ${db_name} ${db_passwd}",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Package["glance"],
	}

	exec {"exec_dbsync":
		cwd => '/tmp/glance/',
		command => "glance-manage --nodebug db_sync",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Exec["exec_db"],
	}

}