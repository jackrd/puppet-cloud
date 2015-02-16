class swift::install {
	package { ["swift", "swift-proxy", "memcached", "python-keystoneclient", "python-swiftclient", "python-webob"]:
		ensure => installed,
	}
}