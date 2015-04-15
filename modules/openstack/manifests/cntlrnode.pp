class openstack::cntlrnode {

	stage {'cntlrnodejob1':
		before => Stage['cntlrnodejob2'],
	}

	stage {'cntlrnodejob2':
		before => Stage['cntlrnodejob3'],
	}

	stage {'cntlrnodejob3':
		before => Stage['cntlrnodejob4'],
	}

	stage {'cntlrnodejob4':
		before => Stage['cntlrnodejob5'],
	}

	stage {'cntlrnodejob5':
		before => Stage['main'],
	}

	stage {'cntlrnodejob6':
		require => Stage['main'],
	}


	class {'base': 	
		stage => cntlrnodejob1,
	}

	class {'keystone': 
		stage => cntlrnodejob2,
	}

	class {'glance': 
		stage => cntlrnodejob3,
	}

	class {'nova': 	
		stage => cntlrnodejob4,
	}

	class {'neutron': 
		stage => cntlrnodejob5,
	}

	class {'horizon': 
		stage => cntlrnodejob6,
	}

	include base
	include keystone
	include glance
	include nova
	include neutron
	include horizon

}