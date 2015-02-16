class nova::dbsetting {

	if $::nodetype == 'controller' {
		file { '/tmp/nova/db.sh':
			source => 'puppet:///modules/nova/script/db.sh',
			mode => 777,
			require => File['/tmp/nova/'],
		}

		exec {"exec_db":
			cwd => '/tmp/nova/',
			command => "/tmp/nova/db.sh ${username} ${passwd} ${db_name} ${db_passwd}",
			path => ["/bin/","/usr/bin/"],
			refreshonly => true,
			subscribe => Package["nova"],
		}

		exec {"exec_dbsync":
			cwd => '/tmp/nova/',
			command => "nova-manage --nodebug db_sync",
			path => ["/bin/","/usr/bin/"],
			refreshonly => true,
			subscribe => Exec["exec_db"],
		}
	}
}