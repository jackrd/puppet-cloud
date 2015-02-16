class glance::install {
	package { ["glance", "python-glanceclient"]:
		ensure => installed,
	}

}