class neutron::config {


if $nodetype == 'cntrnode' {

	file { '/tmp/neutron/neutron_cntlr.sh':
		source => 'puppet://puppet/modules/neutron/script/neutron_cntlr.sh',
		mode => 777,
		require => File['/tmp/neutron/'],
		notify => Exec['exec_neutron_cntlr'],
	}

	exec { "exec_neutron_cntlr":
		command => "bash -c '/tmp/neutron/neutron_cntlr.sh'",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => File["/tmp/neutron/neutron_cntlr.sh"],
		notify => Class["neutron::service"],
	}	

} elsif $nodetype == 'comptnode' {

	file { '/tmp/neutron/neutron_compt.sh':
		source => 'puppet://puppet/modules/neutron/script/neutron_compt.sh',
		mode => 777,
		require => File['/tmp/neutron/'],
		notify => Exec['exec_neutron_compt'],
	}

	exec { "exec_neutron_compt":
		command => "bash -c '/tmp/neutron/neutron_compt.sh'",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => File["/tmp/neutron/neutron_compt.sh"],
		notify => Class["neutron::service"],
	}	


} elsif $nodetype == 'networknode' {

	file { '/tmp/neutron/neutron_network.sh':
		source => 'puppet://puppet/modules/neutron/script/neutron_network.sh',
		mode => 777,
		require => File['/tmp/neutron/'],
		notify => Exec['exec_neutron_network'],
	}
	exec { "exec_neutron_network":
		command => "bash -c '/tmp/neutron/neutron_network.sh'",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => File["/tmp/neutron/neutron_network.sh"],
		notify => Class["neutron::service"],
	}	

	file { '/tmp/neutron/neutron_ovs.sh':
		source => 'puppet://puppet/modules/neutron/script/neutron_ovs.sh',
		mode => 777,
		require => File['/tmp/neutron/'],
		notify => Exec['exec_neutron_ovs'],
	}

	exec { "exec_neutron_ovs":
		command => "bash -c '/tmp/neutron/neutron_ovs.sh'",
		path => ["/bin/","/usr/bin/"],
		refreshonly => true,
		subscribe => [ Package["openvswitch-switch"], File["/tmp/neutron/neutron_ovs.sh"]],
		notify => Class["neutron::service"],
	}
}

}