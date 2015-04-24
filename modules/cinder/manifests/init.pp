class cinder inherits openstack {

	#include ::cntrnode::params

	include cinder::install
	include cinder::env
	include cinder::dbsetting
	include cinder::config 
	include cinder::service

}