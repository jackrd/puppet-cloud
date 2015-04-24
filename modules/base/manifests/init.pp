class base inherits openstack {
	
	include base::install
	include base::env
	include base::dbsetting
	include base::config 
	include base::service

}