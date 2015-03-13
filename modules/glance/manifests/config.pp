class glance::config {

	file { '/tmp/glance/glance_pre.sh':
		source => 'puppet://puppet/modules/glance/script/glance_pre.sh',
		mode => 777,
		require => File['/tmp/glance/'],
	}

	exec { "exec_glance_pre":
		command => "bash -c '/tmp/glance/glance_pre.sh'",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => Package['glance'],
		notify => Exec['exec_glance'],
	}	


	file { '/tmp/glance/glance.sh':
		source => 'puppet://puppet/modules/glance/script/glance.sh',
		mode => 777,
		require => File['/tmp/glance/'],
	}

	exec { "exec_glance":
		command => "bash -c '/tmp/glance/glance.sh'",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => File["/tmp/glance/glance.sh"],
		notify => Class["glance::service"],
	}	

	

}