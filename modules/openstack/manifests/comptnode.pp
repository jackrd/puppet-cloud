class openstack::comptnode {

stage {'comptnodejob1':
		before => Stage['comptnodejob2'],
	}

	stage {'comptnodejob2':
		before => Stage['comptnodejob3'],
	}

	stage {'comptnodejob3':
		before => Stage['comptnodejob4'],
	}

	stage {'comptnodejob4':
		before => Stage['comptnodejob5'],
	}

	stage {'comptnodejob5':
		before => Stage['main'],
	}

	stage {'comptnodejob6':
		require => Stage['main'],
	}


	class {'base': 	
		stage => comptnodejob1,
	}

	class {'keystone': 
		stage => comptnodejob2,
	}

	class {'glance': 
		stage => comptnodejob3,
	}

	class {'nova': 	
		stage => comptnodejob4,
	}

	class {'neutron': 
		stage => comptnodejob5,
	}

	class {'horizon': 
		stage => comptnodejob6,
	}

	include base
	include nova
	include neutron

}