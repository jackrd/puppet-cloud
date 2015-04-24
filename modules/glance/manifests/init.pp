class glance inherits openstack {
	include glance::install
	include glance::env
	include glance::dbsetting
	include glance::config
	include glance::service

}