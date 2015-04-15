class neutron {

	stage {'neutronJob1':
		before => stage['neutronJob2'],
	}
	stage {'neutronJob2':
		before => stage['neutronJob3'],
	}
	stage {'neutronJob3':
		before => stage['neutronJob4'],
	}
	stage {'neutronJob4':
		before => stage['main'],
	}
	stage {'neutronJob5':
		require => stage['main'],
	}


	class {'neutron::install': stage=>neutronJob1,}
	class {'neutron::env': stage=>neutronJob2,}
	class {'neutron::dbsetting': stage=>neutronJob3,}
	class {'neutron::config': stage=>neutronJob4,}
	class {'neutron::service': stage=>neutronJob5,}

	include neutron::install
	include neutron::env
	include neutron::dbsetting { 'db_neutron':
		username =>$db_username,
		passwd => $db_passwd,
		db_name => $neutron_db_name,
		db_passwd => $neutron_db_passwd,
	}
	include neutron::config 
	include neutron::service
}