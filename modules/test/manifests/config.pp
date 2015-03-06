class test::config {
	include test::env
	
	file { '/tmp/test/script':
		ensure => directory,
	}
	
	file { '/tmp/test/script/aa.sh':
		source => 'puppet:///modules/test/script/aa.sh',
		mode => 777,
		require => File['/tmp/test/script'],
	}
	
	file { '/tmp/test/script/exec.sh':
		source => 'puppet:///modules/test/script/exec.sh',
		mode => 777,
		require => File['/tmp/test/script'],
	}	
	
	exec { "exec_aa":
		command => "/tmp/test/script/aa.sh",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		logoutput => on_failure,
		subscribe => [ File['/tmp/test/script/aa.sh'], File['/tmp/test/env/ww.sh'] ],
		#notify => Service["ntp"],
	}
	

	exec { "exec_exec":
		command => "/tmp/test/script/exec.sh",
		path => ["/bin/"],
		refreshonly => true,
		subscribe =>  [ File['/tmp/test/script/aa.sh'], File['/tmp/test/script/exec.sh'] ],
	}
	
}
