class glance::dbsetting inherits glance {

	exec { "exec_glance_remove_default_db":
		command => "rm -rf /var/lib/glance/glance.sqlite",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Class['glance::install'],
	}

	exec { "create-glance-db":
   		#unless  => "/usr/bin/mysql -u${user} -p${password} ${name}",
    		command => "/usr/bin/mysql -u${db_username} -p${db_passwd} -e \"create database ${glance_db_name};\
				grant all privileges on ${glance_db_name}.* to ${glance_db_name}@'localhost' identified by '${glance_db_passwd}'; \
				grant all privileges on ${glance_db_name}.* to ${glance_db_name}@'%' identified by '${glance_db_passwd}';\"",
		require => Service['mysql'],
		refreshonly => true,
		subscribe => Class['glance::install'],
		notify => Exec['exec_glance_dbsync'],
  	}

	exec {"exec_glance_dbsync":
		cwd => '/tmp/glance/',
		path => ["/bin/","/usr/bin/"],
		command => "glance-manage --nodebug db_sync &> /tmp/glance/dbsync.txt",
		refreshonly => true,
		subscribe =>  Exec['create-glance-db'],
		notify => Exec['exec_glance'],
	}
}