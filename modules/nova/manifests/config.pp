class nova::config {

	if $nodetype == 'cntrnode' {
		file { '/tmp/nova/nova_cntlr.sh':
			source => 'puppet://puppet/modules/nova/script/nova_cntlr.sh',
			mode => 777,
			require => File['/tmp/nova/'],
		}

		exec { "exec_nova_cntlr":
			command => "bash -c '/tmp/nova/nova_cntlr.sh'",
			path => ["/bin/","/usr/bin/"],
			refreshonly => true,
			subscribe => File["/tmp/nova/nova_cntlr.sh"],
			notify => Class["nova::service"],
		}	
	} elsif $nodetype == 'comptnode' { 

		file { '/tmp/nova/nova_compt.sh':
			source => 'puppet://puppet/modules/nova/script/nova_compt.sh',
			mode => 777,
			require => File['/tmp/nova/'],
		}
		
		exec { "exec_nova_compt":
			command => "bash -c '/tmp/nova/nova_compt.sh'",
			path => ["/bin/","/usr/bin/"],
			refreshonly => true,
			subscribe => File["/tmp/nova/nova_compt.sh"],
			notify => Class["nova::service"],
		}	
	}
}