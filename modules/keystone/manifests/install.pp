class keystone::install {
	package { ["keystone"]:
		ensure => installed,
	}

}