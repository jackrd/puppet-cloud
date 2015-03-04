class keystone::config {


	file { '/tmp/keystone/keystone.sh':
		source => 'puppet://puppet/modules/keystone/script/keystone.sh',
		mode => 777,
		require => File['/tmp/keystone/'],
	}

	exec { "exec_keystone":
		command => "bash -c '/tmp/keystone/keystone.sh'",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => File["/tmp/keystone/keystone.sh"],
		notify => Class["keystone::service"],
	}

	
	#exec { "exec_keystone_createEndpoint":
	#	command => "keystone endpoint-create --service-id $(keystone service-list | awk '/ identity ${serviceName} --type ${serviceType} --description ${serviceDesc}",
	#	path => ["/bin/","/usr/bin/"],
	#	refreshonly => true,
	#	subscribe => Package["keystone"],
	#}

}