class base::env inherits base {
	
	file { '/tmp/env/':
		ensure => directory,
	}
	
	file { '/tmp/base/':
		ensure => directory,
	}

	file { '/tmp/base/env/':
		ensure => directory,
	}

	file { "/tmp/env/setuprc.sh":
		ensure => present,
		content => template("base/env/setuprc.sh.erb"),
		mode => 777,
		#notify => Class["base::config"]
	}
	
	#exec { "exec_chmod":
	#	command => "bash -c  'chmod +x /tmp/env/*.sh'",
	#	path => ["/bin/","/usr/bin/"],
	#	notify => Class["base::config"]
	#}

	file { '/tmp/base/env/admin-openrc.sh':
		ensure => present,
		content => template("base/env/admin-openrc.sh.erb"),
		mode => 777,
	}

	file { '/tmp/base/env/admin-closerc.sh':
		source => 'puppet:///modules/base/script/admin-closerc.sh',
		mode => 777,
	}
	

}