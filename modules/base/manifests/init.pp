class base {
	include ::cntrnode::params

	include base::install
	#include base::env
	include base::config 
	include base::service
}