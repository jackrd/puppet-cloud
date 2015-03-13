class neutron {
	include neutron::install
	include neutron::env
	neutron::dbsetting { 'db_neutron':
		username =>$db_username,
		passwd => $db_passwd,
		db_name => $neutron_db_name,
		db_passwd => $neutron_db_passwd,
	}
	include neutron::config 
	include neutron::service
}