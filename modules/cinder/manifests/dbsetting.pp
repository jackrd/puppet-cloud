class cinder::dbsetting inherits cinder{

	if $nodetype == 'cntrnode' {
		exec { "exec_cinder_remove_default_db":
			command => "rm -rf /var/lib/cinder/cinder.sqlite",
			path => ["/bin/","/usr/bin/"],
			refreshonly => true,
			subscribe => Class['cinder::install'],
		}

		exec { "create-cinder-db":
			 command => "/usr/bin/mysql -u${db_username} -p${db_passwd} -e \"create database ${cinder_db_name}; \
				grant all privileges on ${cinder_db_name}.* to ${cinder_db_name}@'localhost' identified by '${cinder_db_passwd}'; \	
				grant all privileges on ${cinder_db_name}.* to ${cinder_db_name}@'%' identified by '${cinder_db_passwd}';\"",	    	
			 require => Service['mysql'],
			 refreshonly => true,
			 subscribe => Class['cinder::install'],
			 notify => Exec['exec_cinder_dbsync'],
		}

		exec {"exec_cinder_dbsync":
			cwd => '/tmp/cinder/',
			command => "cinder-manage --nodebug db sync",
			refreshonly => true,
			subscribe =>  Exec['create-cinder-db'],
			notify => Exec['exec_cinder'],
			path => ["/bin/","/usr/bin/"],
		}
	}
}