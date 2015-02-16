class glance::service {
	service { ["glance-registry", "glance-api"]:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
	}
}