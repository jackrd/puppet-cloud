class neutron::config inherits neutron{

	if $nodetype == 'cntrnode' {

		file { '/tmp/neutron/neutron_cntlr_pre.sh':
			 source => 'puppet:///modules/neutron/script/neutron_cntlr_pre.sh',
			 mode => 777,
			 require => File['/tmp/neutron/'],
		}

		exec { "exec_neutron_pre_cntlr":
			 command => "bash -c '/tmp/neutron/neutron_cntlr_pre.sh ${nodetype} ${nEUTRON_PASS} ${nEUTRON_EMAIL}'",
			 path => ["/bin/","/usr/bin/"],
			 require => Service['keystone'], 
			 refreshonly => true,
			 subscribe => [Class['neutron::install'],File['/tmp/neutron/neutron_cntlr_pre.sh']],
			 notify => Exec['exec_neutron_cntlr'],
		}	

		file { '/tmp/neutron/neutron_cntlr.sh':
			 source => 'puppet:///modules/neutron/script/neutron_cntlr.sh',
			 mode => 777,
			 require => File['/tmp/neutron/'],
		}

		exec { "exec_neutron_cntlr":
			 command => "bash -c '/tmp/neutron/neutron_cntlr.sh'",
			 path => ["/bin/","/usr/bin/"],
			 refreshonly => true,
			 subscribe => [File["/tmp/neutron/neutron_cntlr.sh"],File["/tmp/neutron/env/neutronrc.sh"]],
			 require => [File["/tmp/neutron/neutron_cntlr.sh"],File["/tmp/neutron/env/neutronrc.sh"]],
			 #notify => [ Class["nova::service"],Class["neutron::service"]],
			 notify => Class["neutron::service"],
		}	

		file { '/tmp/neutron/neutron_cntlr_post.sh':
			 source => 'puppet:///modules/neutron/script/neutron_cntlr_post.sh',
			 mode => 777,
			 require => File['/tmp/neutron/'],
		}

		exec { "exec_neutron_cntlr_post":
			 command => "bash -c '/tmp/neutron/neutron_cntlr_post.sh ${fLOATING_IP_START } ${fLOATING_IP_END}  ${eXTERNAL_NETWORK_GATEWAY} ${eXTERNAL_NETWORK_CIDR}  ${tENANT_NETWORK_GATEWAY} ${tENANT_NETWORK_CIDR}'",
			 path => ["/bin/","/usr/bin/"],
			 refreshonly => true,
			 subscribe => [Class['neutron::install'],File['/tmp/neutron/neutron_cntlr_post.sh']],
			 require => [File["/tmp/neutron/neutron_cntlr_post.sh"],Class['neutron::service']],
		}	
	} elsif $nodetype == 'comptnode' {

		file { '/tmp/neutron/neutron_ovs.sh':
			 source => 'puppet:///modules/neutron/script/neutron_ovs.sh',
			 mode => 777,
			 require => File['/tmp/neutron/'],
		}

		exec { "exec_neutron_compt_ovs":
			 onlyif => 'service openvswitch-switch restart',
			 command => "bash -c '/tmp/neutron/neutron_ovs.sh ${nodetype} ${iNTERFACE_NAME}'",
			 path => ["/bin/","/usr/bin/"],
			 refreshonly => true,
			 subscribe => Class['neutron::install'],
			 #require => [Service['openvswitch-switch'],File['/tmp/neutron/neutron_ovs.sh']],
			 require => File['/tmp/neutron/neutron_ovs.sh'],
			 notify => Exec['exec_neutron_compt'],
		}

		file { '/tmp/neutron/neutron_compt.sh':
			 source => 'puppet:///modules/neutron/script/neutron_compt.sh',
			 mode => 777,
			 require => File['/tmp/neutron/'],
		}

		exec { "exec_neutron_compt":
			   onlyif => 'service nova-compute restart',
			 command => "bash -c '/tmp/neutron/neutron_compt.sh'",
			 path => ["/bin/","/usr/bin/"],
			  refreshonly => true,
			 subscribe => [File["/tmp/neutron/neutron_compt.sh"],File["/tmp/neutron/env/neutronrc.sh"]],
			 require => [File["/tmp/neutron/neutron_compt.sh"],File["/tmp/neutron/env/neutronrc.sh"]],
			 #notify => Service['nova-compute'],
		}	

	} elsif $nodetype == 'networknode' {

		file { '/tmp/neutron/neutron_ovs.sh':
			 source => 'puppet:///modules/neutron/script/neutron_ovs.sh',
			 mode => 777,
			 require => File['/tmp/neutron/'],
		}

		exec { "exec_neutron_network_ovs":
			 onlyif => 'service openvswitch-switch restart',
			 command => "bash -c '/tmp/neutron/neutron_ovs.sh ${nodetype} ${iNTERFACE_NAME}'",
			 path => ["/bin/","/usr/bin/","/sbin/"],
			 refreshonly => true,
			 subscribe => Class['neutron::install'],
			 require => File['/tmp/neutron/neutron_ovs.sh'],
			 notify => Exec['exec_neutron_network'],
		}

		file { '/tmp/neutron/neutron_network.sh':
			 source => 'puppet:///modules/neutron/script/neutron_network.sh',
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
