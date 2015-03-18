define nova::dbsetting( $username, $passwd,$db_name, $db_passwd) {


	exec { "exec_nova_remove_default_db":
		command => "rm -rf /var/lib/nova/nova.sqlite",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Class['nova::install'],
	}

	if $nodetype == 'cntrnode' {

	exec { "create-nova-db":
   		   unless  => "/usr/bin/mysql -u${user} -p${password} ${name}",
    		  command => "/usr/bin/mysql -u${username} -p${passwd} -e \"create database ${db_name}; grant all privileges on ${db_name}.* to ${db_name}@'localhost' identified by '${db_passwd}'; grant all privileges on ${db_name}.* to ${db_name}@'%' identified by '${db_passwd}';\"",
		   require => Service['mysql'],
		  refreshonly => true,
		  subscribe => Package['nova-api'],
		  notify => Exec['exec_nova_dbsync'],
 	}

	exec {"exec_nova_dbsync":
		cwd => '/tmp/nova/',
		command => "nova-manage --nodebug db sync",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe =>  Exec['create-nova-db'],
		notify => Exec['exec_nova_cntlr'],
	}

	}
}