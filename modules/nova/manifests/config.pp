class nova::config inherits nova{

	if $nodetype == 'cntrnode' {

		file { '/tmp/nova/nova_cntlr_pre.sh':
			 source => 'puppet:///modules/nova/script/nova_cntlr_pre.sh',
			 mode => 777,
			 require => File['/tmp/nova/'],
		}

		exec { "exec_nova_pre_cntlr":
			 command => "bash -c '/tmp/nova/nova_cntlr_pre.sh ${nodetype} ${gLANCE_PASS} ${gLANCE_EMAIL}'",
			 path => ["/bin/","/usr/bin/"],
			 require => Service['keystone'],
			  refreshonly => true,
			 subscribe => [Class['nova::install'],File['/tmp/nova/nova_cntlr_pre.sh']],
			 #notify => Exec['exec_nova_cntlr'],
		}	

		file { '/tmp/nova/nova_cntlr.sh':
			 source => 'puppet:///modules/nova/script/nova_cntlr.sh',
			 mode => 777,
			 require => File['/tmp/nova/'],
		}

		exec { "exec_nova_cntlr":
			 command => "bash -c '/tmp/nova/nova_cntlr.sh'",
			 path => ["/bin/","/usr/bin/"],
			 refreshonly => true,
			 subscribe => [ File["/tmp/nova/nova_cntlr.sh"],File["/tmp/nova/env/novarc.sh"]],
			 notify => Class["nova::service"],
		}	
	} elsif $nodetype == 'comptnode' { 
	

		file { '/tmp/nova/nova_compt.sh':
			 source => 'puppet:///modules/nova/script/nova_compt.sh',
			 mode => 777,
			 require => File['/tmp/nova/'],
		}
		
		exec { "exec_nova_compt":
			 command => "bash -c '/tmp/nova/nova_compt.sh'",
			 path => ["/bin/","/usr/bin/"],
			 refreshonly => true,
			 subscribe => [ File["/tmp/nova/nova_compt.sh"],File["/tmp/nova/env/novarc.sh"]],
			 notify => Class["nova::service"],
		}
	}
}