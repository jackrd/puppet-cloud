class openstack::networknode {


	stage {'networknodejob1':
		before => Stage['main'],
	}

	stage {'networknodejob2':
		require => Stage['main'],
	}


	class {'base': 	
		stage => networknodejob1,
	}

	
	class {'neutron': 
		stage => networknodejob2,
	}

}