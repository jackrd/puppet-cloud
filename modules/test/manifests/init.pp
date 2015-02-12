class test {
	#include ::cntrnode::params

	test::createuser { ' test_createuser':
		username => 'jack',
		password => '111111'
	}

	include test::install

	include test::dbsetting
	include test::env
	include test::config 
	include test::service
}