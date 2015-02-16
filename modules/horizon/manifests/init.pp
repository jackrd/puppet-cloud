class horizon {
	include horizon::install
	include horizon::env
	include horizon::dbsetting
	include horizon::config 
	include horizon::service
}