class test::install {

	package { ["ntp"]:
		ensure => installed,
	}
}