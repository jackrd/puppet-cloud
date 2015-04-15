class base::config {


	file { "/tmp/base/base.sh":
		source => 'puppet:///modules/base/script/base.sh',
		mode => 777,
		require => File['/tmp/base/'],
	}

	file { "/tmp/base/rabbitmqctl.sh":
		source => 'puppet:///modules/base/script/rabbitmqctl.sh',
		mode => 777,
		require => File['/tmp/base/'],
	}
	
	if $nodetype == 'cntrnode' {

		exec {"exec_rabbitmq":
			cwd => '/tmp/base/',
			#command => "rabbitmqctl change_password guest ${rABBIT_PASS} &> /tmp/base/rabbitmqctl.txt",
			command => "bash -c '/tmp/base/rabbitmqctl.sh ${rABBIT_PASS}'",
			path => ["/bin/","/usr/sbin/", "/usr/bin/"],
			require => Service["rabbitmq-server"],
			refreshonly => true,
			subscribe => Package["rabbitmq-server"],
			#notify => Service["rabbitmq-server"],

		}
	}

	exec { "exec_base":
		command => "bash -c '/tmp/base/base.sh ${nodetype}'",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => [ File['/tmp/base/base.sh'],File['/tmp/env/setuprc.sh'] ],
		notify => Class["base::service"],
	}
	
}