class horizon::env {
	
	include horizon::params

	file { '/tmp/horizon/':
		ensure => directory,
	}

	file { '/tmp/horizon/env/':
		ensure => directory,
	}

	file { '/tmp/horizon/env/horizonrc.sh':
		ensure => present,
		content => template("horizon/env/horizonrc.sh.erb"),
		mode => 777,
	}

}