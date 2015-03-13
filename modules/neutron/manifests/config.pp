class neutron::config {

	if $nodetype == 'cntrnode' {

		file { '/tmp/neutron/neutron_cntlr_pre.sh':
			 source => 'puppet://puppet/modules/neutron/script/neutron_cntlr_pre.sh',
			 mode => 777,
			 require => File['/tmp/neutron/'],
		}

		exec { "exec_neutron_pre_cntlr":
			 command => "bash -c '/tmp/neutron/neutron_cntlr_pre.sh'",
			 path => ["/bin/","/usr/bin/"],
			 refreshonly => true,
			 subscribe => Class['neutron::install'],
			 notify => Exec['exec_neutron_cntlr'],
		}	

		file { '/tmp/neutron/neutron_cntlr.sh':
			 source => 'puppet://puppet/modules/neutron/script/neutron_cntlr.sh',
			 mode => 777,
			 require => File['/tmp/neutron/'],
		}

		exec { "exec_neutron_cntlr":
			 command => "bash -c '/tmp/neutron/neutron_cntlr.sh'",
			 path => ["/bin/","/usr/bin/"],
			 refreshonly => true,
			 subscribe => [File["/tmp/neutron/neutron_cntlr.sh"],File["/tmp/neutron/env/neutronrc.sh"]],
			 require => [File["/tmp/neutron/neutron_cntlr.sh"],File["/tmp/neutron/env/neutronrc.sh"]],
			 notify => [ Class["nova::service"],Class["neutron::service"]],
		}	

		file { '/tmp/neutron/neutron_cntlr_post.sh':
			 source => 'puppet://puppet/modules/neutron/script/neutron_cntlr_post.sh',
			 mode => 777,
			 require => File['/tmp/neutron/'],
		}

		exec { "exec_neutron_cntlr_post":
			 command => "bash -c '/tmp/neutron/neutron_cntlr_post.sh'",
			 path => ["/bin/","/usr/bin/"],
			 refreshonly => true,
			 subscribe => Class['neutron::install'],
			 require => [File["/tmp/neutron/neutron_cntlr_post.sh"],Class['neutron::service']],
		}	
	} elsif $nodetype == 'comptnode' {

		file { '/tmp/neutron/neutron_ovs.sh':
			 source => 'puppet://puppet/modules/neutron/script/neutron_ovs.sh',
			 mode => 777,
			 require => File['/tmp/neutron/'],
		}

		exec { "exec_neutron_compt_ovs":
			 onlyif => ' service openvswitch-switch restart',
			 command => "bash -c '/tmp/neutron/neutron_ovs.sh ${nodetype}'",
			 path => ["/bin/","/usr/bin/"],
			 refreshonly => true,
			 subscribe => Class['neutron::install'],
			 require => [Service['openvswitch-switch'],File['/tmp/neutron/neutron_ovs.sh']],
			 notify => Exec['exec_neutron_compt'],
		}

		file { '/tmp/neutron/neutron_compt.sh':
			 source => 'puppet://puppet/modules/neutron/script/neutron_compt.sh',
			 mode => 777,
			 require => File['/tmp/neutron/'],
		}

		exec { "exec_neutron_compt":
			 command => "bash -c '/tmp/neutron/neutron_compt.sh'",
			 path => ["/bin/","/usr/bin/"],
			  refreshonly => true,
			 subscribe => [File["/tmp/neutron/neutron_compt.sh"],File["/tmp/neutron/env/neutronrc.sh"]],
			 require => [File["/tmp/neutron/neutron_compt.sh"],File["/tmp/neutron/env/neutronrc.sh"]],
			 notify => Service['nova-compute'],
		}	

	} elsif $nodetype == 'networknode' {

		file { '/tmp/neutron/neutron_ovs.sh':
			 source => 'puppet://puppet/modules/neutron/script/neutron_ovs.sh',
			 mode => 777,
			 require => File['/tmp/neutron/'],
		}

		exec { "exec_neutron_network_ovs":
			 onlyif => ' service openvswitch-switch restart',
			 command => "bash -c '/tmp/neutron/neutron_ovs.sh ${nodetype}'",
			 path => ["/bin/","/usr/bin/"],
			 refreshonly => true,
			 subscribe => Class['neutron::install'],
			 require => File['/tmp/neutron/neutron_ovs.sh'],
			 notify => Exec['exec_neutron_network'],
		}

		file { '/tmp/neutron/neutron_network.sh':
			 source => 'puppet://puppet/modules/neutron/script/neutron_network.sh',
			 mode => 777,
			 require => File['/tmp/neutron/'],
		}

		exec { "exec_neutron_network":
			 #onlyif => 'service nova-api restart',
			 command => "bash -c '/tmp/neutron/neutron_network.sh'",
			 path => ["/bin/","/usr/bin/"],
			  refreshonly => true,
			 subscribe => [File["/tmp/neutron/neutron_network.sh"],File["/tmp/neutron/env/neutronrc.sh"]],
			 require => [File["/tmp/neutron/neutron_network.sh"],File["/tmp/neutron/env/neutronrc.sh"]],
			 notify => Class["neutron::service"],
		}
	}

}