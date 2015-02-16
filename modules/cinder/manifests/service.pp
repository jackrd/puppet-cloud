class cinder::service {
	service { ["cinder-scheduler","cinder-api"]:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		#require => Class["cinder::config"],
	}
}