class keystone::service {
	service { ["keystone"]:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
	}
}