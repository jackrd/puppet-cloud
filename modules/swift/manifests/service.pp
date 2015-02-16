class swift::service {
	service { ["swift-proxy", "memcached"]:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
	}
}