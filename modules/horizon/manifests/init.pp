class horizon inherits openstack{
	include horizon::install
	include horizon::env
	include horizon::config 
	include horizon::service
}