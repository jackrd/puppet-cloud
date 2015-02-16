class cinder::install {
	package { ["cinder-api", "cinder-scheduler"]:
		ensure => installed,
	}
}