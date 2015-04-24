class neutron::dbsetting inherits neutron{

	if $nodetype == 'cntrnode' {

		exec { "create-neutron-db":
			 #unless  => "/usr/bin/mysql -u${user} -p${password} ${name}",
			 command => "/usr/bin/mysql -u${db_username} -p${db_passwd} -e \"create database ${neutron_db_name}; \
				grant all privileges on ${neutron_db_name}.* to ${neutron_db_name}@'localhost' identified by '${neutron_db_passwd}'; \
				grant all privileges on ${neutron_db_name}.* to ${neutron_db_name}@'%' identified by '${neutron_db_passwd}';\"",
			 require => Service['mysql'],
			 refreshonly => true,
			 subscribe => Class['neutron::install'],
			 #notify => Exec['exec_neutron_dbsync'],
		}

	}
}
