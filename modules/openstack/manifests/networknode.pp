class openstack::networknode {

stage {'networknodejob1':
		before => Stage['networknodejob2'],
	}

	stage {'networknodejob2':
		before => Stage['networknodejob3'],
	}

	stage {'networknodejob3':
		before => Stage['networknodejob4'],
	}

	stage {'networknodejob4':
		before => Stage['networknodejob5'],
	}

	stage {'networknodejob5':
		before => Stage['main'],
	}

	stage {'networknodejob6':
		require => Stage['main'],
	}


	class {'base': 	
		stage => networknodejob1,
	}

	class {'keystone': 
		stage => networknodejob2,
	}

	class {'glance': 
		stage => networknodejob3,
	}

	class {'nova': 	
		stage => networknodejob4,
	}

	class {'neutron': 
		stage => networknodejob5,
	}

	class {'horizon': 
		stage => networknodejob6,
	}

	include base
	include neutron

}