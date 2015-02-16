class base::config {

	file { '/tmp/base/':
		ensure => directory,
	}
	
	file { "/tmp/base/base.sh":
		source => 'puppet://puppet/modules/base/script/base.sh',
		mode => 777,
		require => File['/tmp/base/'],
	}
	
	exec { "exec_base":
		command => "bash -c '/tmp/base/base.sh'",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => File['/tmp/base/base.sh'],
		notify => Class["base::service"],
	}	
}