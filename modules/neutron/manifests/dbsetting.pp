define neutron::dbsetting( $username, $passwd,$db_name, $db_passwd) {

	if $nodetype == 'cntrnode' {
		exec { "create-neutron-db":
			 unless  => "/usr/bin/mysql -u${user} -p${password} ${name}",
			 command => "/usr/bin/mysql -u${username} -p${passwd} -e \"create database ${db_name}; grant all privileges on ${db_name}.* to ${db_name}@'localhost' identified by '${db_passwd}'; grant all privileges on ${db_name}.* to ${db_name}@'%' identified by '${db_passwd}';\"",
			 require => Service['mysql'],
			 refreshonly => true,
			 subscribe => Package['neutron-server'],
			 notify => Exec['exec_neutron_dbsync'],
		}

		exec {"exec_neutron_dbsync":
			 cwd => '/tmp/neutron/',
			 command => "neutron-manage --nodebug db_sync",
			 path => ["/bin/","/usr/bin/"],
			 refreshonly => true,
			 subscribe =>  Exec['create-neutron-db'],

		}
	}
}
