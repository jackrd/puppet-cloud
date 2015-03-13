class glance {
	include glance::install
	include glance::env
	glance::dbsetting { 'db_glance':
		username =>$db_username,
		passwd => $db_passwd,
		db_name => $glance_db_name,
		db_passwd => $glance_db_passwd,
	}
	include glance::config 
	include glance::service
}