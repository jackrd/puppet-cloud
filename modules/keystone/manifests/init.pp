class keystone {

	#include ::cntrnode::params
	
	include keystone::install
	include keystone::env
	#include keystone::dbsetting
	keystone::dbsetting { 'db':
		username =>$db_username,
		passwd => $db_passwd,
		db_name => $keystone_db_name,
		db_passwd => $keystone_db_passwd,
	}
	include keystone::config 
	include keystone::service
}