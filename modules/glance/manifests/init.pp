class glance {

	stage {'glanceJob1':
		before => stage['glanceJob2'],
	}
	stage {'glanceJob2':
		before => stage['glanceJob3'],
	}
	stage {'glanceJob3':
		before => stage['glanceJob4'],
	}
	stage {'glanceJob4':
		before => stage['main'],
	}
	stage {'glanceJob5':
		require => stage['main'],
	}


	class {'glance::install': stage=>glanceJob1,}
	class {'glance::env': stage=>glanceJob2,}
	class {'glance::dbsetting': stage=>glanceJob3,}
	class {'glance::config': stage=>glanceJob4,}
	class {'glance::service': stage=>glanceJob5,}


	include glance::install
	include glance::env
	include glance::dbsetting { 'db_glance':
		username =>$db_username,
		passwd => $db_passwd,
		db_name => $glance_db_name,
		db_passwd => $glance_db_passwd,
	}
	include glance::config 
	include glance::service
}