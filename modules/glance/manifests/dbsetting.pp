class glance::dbsetting {

	file { '/tmp/glance/db.sh':
		source => 'puppet:///modules/glance/script/db.sh',
		mode => 777,
		require => File['/tmp/glance/'],
	}

	exec {"exec_glance_db":
		cwd => '/tmp/glance/',
		command => "/tmp/glance/db.sh ${username} ${passwd} ${glance_db_name} ${glance_db_passwd}",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => [ Package["glance"],File["/tmp/glance/db.sh"] ],
	}

	exec {"exec_glance_dbsync":
		cwd => '/tmp/glance/',
		command => "glance-manage --nodebug db_sync",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Exec["exec_glance_db"],
	}

}