class base::dbsetting {

	if $nodetype == 'cntrnode' {

		file { '/tmp/base/db.sh':
			 source => 'puppet:///modules/base/script/db.sh',
			 mode => 777,
			 require => File['/tmp/base/'],
		}

		exec {"exec_init_db":
			 cwd => '/tmp/base/',
			 command => "mysql_install_db",
			 path => ["/bin/","/usr/bin/"],
			 refreshonly => true,
			 subscribe => Package["mysql-server"],
			 require => Service['mysql'],

		}
		
		exec {"mysql-autosecure":
			 cwd => '/tmp/base/',
			 command => "sh /tmp/base/db.sh ${db_passwd}",
			 path => ["/bin/","/usr/bin/"],
			 creates => "/tmp/base/mysql_secure_installation.ran",
			 logoutput => true,
			 refreshonly => true,
			 subscribe => [ Exec["exec_init_db"], File["/tmp/base/db.sh"] ],
			 require => Service['mysql'],
		}

	}
}