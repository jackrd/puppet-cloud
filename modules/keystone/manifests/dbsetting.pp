define keystone::dbsetting( $username, $passwd,$db_name, $db_passwd) {

	exec { "exec_keystone_remove_default_db":
		command => "rm /var/lib/keystone/keystone.sqlite",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Class['keystone::install'],
	}


	exec { "create-keystone-db":
   		 unless  => "/usr/bin/mysql -u${user} -p${password} ${name}",
    		 command => "/usr/bin/mysql -u${username} -p${passwd} -e \"create database ${db_name}; grant all privileges on ${db_name}.* to ${db_name}@'localhost' identified by '${db_passwd}'; grant all privileges on ${db_name}.* to ${db_name}@'%' identified by '${db_passwd}';\"",
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