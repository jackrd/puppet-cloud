class cinder::config {

	file { '/tmp/cntr/cinder':
		source => 'puppet://puppet/modules/cinder/script',
		recurse => true,
		mode => 777,
		require => File['/tmp/cntr/cinder/'],
		notify => Exec['exec_openstack_08_cinder_cntlr'],
		#notify => Exec["cinder::config::basic"],
	}

	exec { "exec_openstack_08_cinder_cntlr":
		command => "bash -c '/tmp/cntr/controller/openstack_08_cinder_cntlr.sh'",
		path => ["/bin/","/usr/bin/"],
		#require => Exec["exec_openstack_03_keystone"],
		notify => Class["config::service"],
	}	

}