class keystone inherits openstack {

	include keystone::install
	include keystone::env
	include keystone::dbsetting
	include keystone::config 
	include keystone::service

}