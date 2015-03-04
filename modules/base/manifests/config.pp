class base::config {


	file { "/tmp/base/base.sh":
		source => 'puppet://puppet/modules/base/script/base.sh',
		mode => 777,
		require => File['/tmp/base/'],
	}
	
	if $nodetype == 'cntrnode' {

		exec {"exec_rabbitmq":
			cwd => '/tmp/base/',
			command => "rabbitmqctl change_password guest ${rabbitpwd} &> /dev/null",
			path => ["/bin/","/usr/sbin/"],
			refreshonly => true,
			subscribe => Package["rabbitmq-server"],
			notify => Service["rabbitmq-server"],

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