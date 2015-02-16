class nova::service {
	service { ["nova-api", "nova-cert", "nova-consoleauth", "nova-scheduler", "nova-conduct", "nova-novncproxy"]:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		#require => Class["nova::config"],
	}
}