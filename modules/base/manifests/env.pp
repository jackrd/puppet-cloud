class base::env {
	
	include base::params

	file { '/tmp/env/':
		ensure => directory,
		notify => File["/tmp/env/setuprc.sh"],
	}
	
	file { "/tmp/env/setuprc.sh":
		ensure => present,
		content => template("base/env/setuprc.sh.erb"),
		mode => 777,
	}
	
	exec { "exec_chmod":
		command => "bash -c  'chmod +x /tmp/env/*.sh'",
		path => ["/bin/","/usr/bin/"],
		notify => Class["base::config"]
	}

	

}