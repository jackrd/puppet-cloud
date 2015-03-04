class nova::dbsetting {

	if $::nodetype == 'cntrnode' {

		file { '/tmp/nova/db.sh':
			source => 'puppet:///modules/nova/script/db.sh',
			mode => 777,
			require => File['/tmp/nova/'],
		}

		exec {"exec_nova_db":
			command => "/tmp/nova/db.sh ${username} ${passwd} ${nova_db_name} ${nova_db_passwd}",
			path => ["/bin/","/usr/bin/"],
			refreshonly => true,
			subscribe => Package["nova"],
		}

		exec {"exec_nova_dbsync":
			command => "nova-manage --nodebug db_sync",
			path => ["/bin/","/usr/bin/"],
			refreshonly => true,
			subscribe => Exec["exec_nova_db"],
		}
	}
}