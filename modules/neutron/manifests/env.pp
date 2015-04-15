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

	file { '/tmp/neutron/env/admin-openrc.sh':
		ensure => present,
		content => template("neutron/env/admin-openrc.sh.erb"),
		mode => 777,
	}

	file { '/tmp/neutron/env/admin-closerc.sh':
		source => 'puppet:///modules/neutron/script/admin-closerc.sh',
		mode => 777,
	}

}
