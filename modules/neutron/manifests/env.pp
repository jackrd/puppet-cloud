class neutron::env {
	
	include neutron::params

	file { '/tmp/neutron/':
		ensure => directory,
	}

	file { '/tmp/neutron/env/':
		ensure => directory,
	}
	file { '/tmp/neutron/env/neutronrc.sh':
		ensure => present,
		content => template("neutron/env/neutronrc.sh.erb"),
		mode => 777,
	}

}