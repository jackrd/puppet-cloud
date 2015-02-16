class keystone {

	#include ::cntrnode::params
	
	include keystone::install
	include keystone::env
	include keystone::dbsetting
	include keystone::config 
	include keystone::service
}