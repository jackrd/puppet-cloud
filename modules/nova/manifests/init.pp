class nova {
	include nova::install
	include nova::env
	nova::dbsetting { 'db_nova':
		username =>$db_username,
		passwd => $db_passwd,
		db_name => $nova_db_name,
		db_passwd => $nova_db_passwd,
	}
	include nova::config 
	include nova::service
}