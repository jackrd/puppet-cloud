class keystone {

	#include ::cntrnode::params

	stage {'keystoneJob1':
		before => stage['keystoneJob2'],
	}
	stage {'keystoneJob2':
		before => stage['keystoneJob3'],
	}
	stage {'keystoneJob3':
		before => stage['keystoneJob4'],
	}
	stage {'keystoneJob4':
		before => stage['main'],
	}
	stage {'keystoneJob5':
		require => stage['main'],
	}


	class {'keystone::install': stage=>keystoneJob1,}
	class {'keystone::env': stage=>keystoneJob2,}
	class {'keystone::dbsetting': stage=>keystoneJob3,}
	class {'keystone::config': stage=>keystoneJob4,}
	class {'keystone::service': stage=>keystoneJob5,}

	
	include keystone::install
	include keystone::env
	include keystone::dbsetting { 'db_keystone':
		username =>$db_username,
		passwd => $db_passwd,
		db_name => $keystone_db_name,
		db_passwd => $keystone_db_passwd,
	}
	include keystone::config 
	include keystone::service

}