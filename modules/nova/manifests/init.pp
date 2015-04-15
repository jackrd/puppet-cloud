class nova {

	stage {'novaJob1':
		before => stage['novaJob2'],
	}
	stage {'novaJob2':
		before => stage['novaJob3'],
	}
	stage {'novaJob3':
		before => stage['novaJob4'],
	}
	stage {'novaJob4':
		before => stage['main'],
	}
	stage {'novaJob5':
		require => stage['main'],
	}


	class {'nova::install': stage=>novaJob1,}
	class {'nova::env': stage=>novaJob2,}
	class {'nova::dbsetting': stage=>novaJob3,}
	class {'nova::config': stage=>novaJob4,}
	class {'nova::service': stage=>novaJob5,}

	include nova::install
	include nova::env
	include nova::dbsetting { 'db_nova':
		username =>$db_username,
		passwd => $db_passwd,
		db_name => $nova_db_name,
		db_passwd => $nova_db_passwd,
	}
	include nova::config 
	include nova::service
}