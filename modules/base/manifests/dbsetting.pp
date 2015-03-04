class base::dbsetting {

if $nodetype == 'cntrnode' {
	file { '/tmp/base/db.sh':
		source => 'puppet:///modules/base/script/db.sh',
		mode => 777,
		require => File['/tmp/base/'],
	}

	exec {"exec_dbsync":
		cwd => '/tmp/base/',
		command => "mysql_install_db",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Package["mysql-server"],

	}

	exec {"exec_db":
		cwd => '/tmp/base/',
		command => "/tmp/base/db.sh ${db_passwd}",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => [ Exec["exec_dbsync"], File["/tmp/base/db.sh"] ],
	}

}

}