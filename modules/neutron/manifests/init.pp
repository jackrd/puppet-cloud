class neutron inherits openstack{
	include neutron::install
	include neutron::env
	include neutron::dbsetting
	include neutron::config 
	include neutron::service
}