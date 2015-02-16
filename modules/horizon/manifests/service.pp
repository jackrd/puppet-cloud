class horizon::service {
	service { ["apache2","memcached"]:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
	}
}