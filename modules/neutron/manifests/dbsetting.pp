class neutron::dbsetting {

	if $nodetype == 'cntrnode' {
	file { '/tmp/neutron/db.sh':
		source => 'puppet:///modules/neutron/script/db.sh',
		mode => 777,
		require => File['/tmp/neutron/'],
	}

	exec {"exec_neutron_db":
		command => "/tmp/neutron/db.sh ${username} ${passwd} ${neutron_db_name} ${neutron_db_passwd}",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => [ Package["neutron-server"],File["/tmp/neutron/db.sh"]],
	}
	}
}