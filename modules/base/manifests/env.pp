class base::env {
	
	include base::params

	file { '/tmp/env/':
		ensure => directory,
	}
	
	file { '/tmp/base/':
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

	

}