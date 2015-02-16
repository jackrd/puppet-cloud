class horizon::install {
	package { ["apache2", "memcached", "libapache2-mod-wsgi", "openstack-dashboard"]:
		ensure => installed,
	}

	package { ["openstack-dashboard-ubuntu-theme"]:
		ensure => absent,
	}
}