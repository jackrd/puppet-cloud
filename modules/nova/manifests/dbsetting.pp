class nova::dbsetting inherits nova{


	exec { "exec_nova_remove_default_db":
		command => "rm -rf /var/lib/nova/nova.sqlite",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Class['nova::install'],
	}

	if $nodetype == 'cntrnode' {

	exec { "create-nova-db":
   		   #unless  => "/usr/bin/mysql -u${user} -p${password} ${name}",
    		  command => "/usr/bin/mysql -u${db_username} -p${db_passwd} -e \"create database ${nova_db_name}; \
			grant all privileges on ${nova_db_name}.* to ${nova_db_name}@'localhost' identified by '${nova_db_passwd}'; \
			grant all privileges on ${nova_db_name}.* to ${nova_db_name}@'%' identified by '${nova_db_passwd}';\"",
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