class neutron::config {

	file { '/tmp/cntr/neutron':
		source => 'puppet://puppet/modules/neutron/script',
		recurse => true,
		mode => 777,
		require => File['/tmp/cntr/neutron/'],
		notify => Exec['exec_openstack_06_neutron_cntlr'],
		#notify => Exec["neutron::config::basic"],
	}

	exec { "exec_openstack_06_neutron_cntlr":
		command => "bash -c '/tmp/cntr/controller/openstack_06_neutron_cntlr.sh'",
		path => ["/bin/","/usr/bin/"],
		#require => Exec["exec_openstack_03_keystone"],
		notify => Class["config::service"],
	}	

}