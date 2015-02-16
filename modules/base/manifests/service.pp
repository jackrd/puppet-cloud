class base::service {
	service { ["ntp", "mysql"]:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
	}
}