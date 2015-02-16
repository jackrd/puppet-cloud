class nova {
	include nova::install
	include nova::env
	include nova::dbsetting
	include nova::config 
	include nova::service
}