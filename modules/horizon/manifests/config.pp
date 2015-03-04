class horizon::config {

	file { '/tmp/horizon/horizon.sh':
		source => 'puppet://puppet/modules/horizon/script/horizon.sh',
		mode => 777,
		require => File['/tmp/horizon/'],
	}

	exec { "exec_horizon":
		command => "bash -c '/tmp/horizon/horizon.sh'",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => File["/tmp/horizon/horizon.sh"],
		notify => Class["horizon::service"],
	}	

}