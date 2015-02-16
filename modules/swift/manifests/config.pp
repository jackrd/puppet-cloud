class swift::config {

	file { '/tmp/swift/swift_cntr.sh':
		source => 'puppet://puppet/modules/swift/script/swift_cntr.sh',
		mode => 777,
		require => File['/tmp/swift/'],
	}
	
	file { '/tmp/swift/swift_proxy.sh':
		source => 'puppet://puppet/modules/swift/script/swift_proxy.sh',
		mode => 777,
		require => File['/tmp/swift/'],
	}
	exec { "exec_swift_cntlr":
		command => "bash -c '/tmp/controller/swift_cntlr.sh'",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => File["/tmp/swift/swift_cntr.sh"],
		notify => Class["swift::service"],
	}	
	
	exec { "exec_swift_proxy":
		command => "bash -c '/tmp/controller/swift_proxy.sh'",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => File["/tmp/swift/swift_proxy.sh"],
		notify => Class["swift::service"],
	}	
}