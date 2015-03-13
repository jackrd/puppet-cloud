define glance::dbsetting( $username, $passwd,$db_name, $db_passwd) {


	exec { "exec_glance_remove_default_db":
		command => "rm /var/lib/glance/glance.sqlite",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Class['glance::install'],
	}

	exec { "create-glance-db":
   		unless  => "/usr/bin/mysql -u${user} -p${password} ${name}",
    		command => "/usr/bin/mysql -u${username} -p${passwd} -e \"create database ${db_name}; grant all privileges on ${db_name}.* to ${db_name}@'localhost' identified by '${db_passwd}'; grant all privileges on ${db_name}.* to ${db_name}@'%' identified by '${db_passwd}';\"",
		require => Service['mysql'],
		refreshonly => true,
		subscribe => Class['glance::install'],
		notify => Exec['exec_glance_dbsync'],
  	}

	exec {"exec_glance_dbsync":
		cwd => '/tmp/glance/',
		path => ["/bin/","/usr/bin/"],
		command => "glance-manage --nodebug db_sync",
		refreshonly => true,
		subscribe =>  Exec['create-glance-db'],
		notify => Exec['exec_glance'],
	}
}