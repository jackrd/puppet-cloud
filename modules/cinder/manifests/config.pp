class cinder::config inherits cinder{

	if $nodetype == 'cntrnode' {
	
		file { '/tmp/cinder/cinder_cntr_pre.sh':
			 source => 'puppet:///modules/cinder/script/cinder_cntr_pre.sh',
			 mode => 777,
			 require => File['/tmp/cinder/'],
		}

		exec { "exec_cinder_cntr_pre":
			 command => "bash -c '/tmp/cinder/cinder_cntr_pre.sh ${nodetype} ${CINDER_PASS} ${CINDER_EMAIL}'",
			 path => ["/bin/","/usr/bin/"],
			 require => Service['keystone'], 
			 refreshonly => true,
			 subscribe => [Class['cinder::install'],File['/tmp/cinder/cinder_cntr_pre.sh']],
			 notify => Exec['exec_cinder_cntlr'],
		}	

		file { '/tmp/cinder/cinder_cntlr.sh':
			 source => 'puppet:///modules/cinder/script/cinder_cntlr.sh',
			 mode => 777,
			 require => File['/tmp/cinder/'],
		}

		exec { "exec_cinder_cntlr":
			 command => "bash -c '/tmp/cinder/cinder_cntlr.sh'",
			 path => ["/bin/","/usr/bin/"],
			 refreshonly => true,
			 subscribe => [File["/tmp/cinder/cinder_cntlr.sh"],File["/tmp/cinder/env/cinderrc.sh"]],
			 require => [File["/tmp/cinder/cinder_cntlr.sh"],File["/tmp/cinder/env/cinderrc.sh"]],
			 #notify => [Class["nova::service"],Class["cinder::service"]],
			 notify => Class["cinder::service"],
		}	
	}
	} elsif $nodetype == 'blocknode' {
	
		file { '/tmp/cinder/cinder_blk.sh':
			 source => 'puppet:///modules/cinder/script/cinder_blk.sh',
			 mode => 777,
			 require => File['/tmp/cinder/'],
		}

		exec { "exec_cinder_cntlr":
			 command => "bash -c '/tmp/cinder/cinder_blk.sh ${os_partition} ${block_devs}'",
			 path => ["/bin/","/usr/bin/"],
			 refreshonly => true,
			 subscribe => [File["/tmp/cinder/cinder_blk.sh"],File["/tmp/cinder/env/cinderrc.sh"]],
			 require => [File["/tmp/cinder/cinder_blk.sh"],File["/tmp/cinder/env/cinderrc.sh"]],
			 #notify => [ Class["nova::service"],Class["cinder::service"]],
			 notify => Class["cinder::service"],
		}	
	}
}
