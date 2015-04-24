class test {
	#include ::cntrnode::params

	#create  /tmp/$username file and its content is  username and password.
	test::createuser { ' test_createuser':
		username => 'jack',
		password => '111111'
	}

	#installed ntp package
	include test::install

	# copy db.sh to /tmp/test/script/ 
	#run db.sh with parameter $username, $passwd ,$db_name and $db_passwd
	#run keystone-manage --nodebug db_sync
	#include test::dbsetting

	#include test2::env
	include test::env

	#copy aa.sh and exec.sh to /tmp/test/script/ and run both
	#aa.sh will run ww.sh and create /tmp/ttt2.conf
	#exec.sh will create /tmp/command file
	include test::config 

	include test::service
}