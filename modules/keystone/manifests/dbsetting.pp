class keystone::dbsetting inherits keystone{

	exec { "exec_keystone_remove_default_db":
		command => "rm -rf /var/lib/keystone/keystone.sqlite",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Class['keystone::install'],
	}


	exec { "create-keystone-db":
   		 #unless  => "/usr/bin/mysql -u${user} -p${password} ${name}",
    		 command => "/usr/bin/mysql -u${db_username} -p${db_passwd} -e \"create database ${keystone_db_name}; \
				grant all privileges on ${keystone_db_name}.* to ${keystone_db_name}@'localhost' identified by '${keystone_db_passwd}'; \
			   	grant all privileges on ${keystone_db_name}.* to ${keystone_db_name}@'%' identified by '${keystone_db_passwd}';\"",
		 require => Service['mysql'],
		 refreshonly => true,
		 subscribe => Class['keystone::install'],
		 notify => Exec['exec_keystone_dbsync'],
	}

	exec {"exec_keystone_dbsync":
		cwd => '/tmp/keystone/',
		command => "keystone-manage --nodebug db_sync",
		refreshonly => true,
		subscribe =>  Exec['create-keystone-db'],
		notify => Exec['exec_keystone'],
		path => ["/bin/","/usr/bin/"],
	}

}