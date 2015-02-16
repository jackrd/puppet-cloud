class neutron {
	include neutron::install
	include neutron::env
	include neutron::dbsetting
	include neutron::config 
	include neutron::service
}