class test::service {
	#service { ["ntp"]:
	#	ensure => running,
	#	hasstatus => true,
	#	hasrestart => true,
	#	enable => true,
	#	#require => Class["test::config"],
	#}
}