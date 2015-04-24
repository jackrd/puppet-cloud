class openstack::comptnode {

	stage {'comptnodejob1':
		before => Stage['comptnodejob2'],
	}

	stage {'comptnodejob2':
		before => Stage['main'],
	}

	stage {'comptnodejob3':
		require => Stage['main'],
	}


	class {'base': 	
		stage => comptnodejob1,
	}

	class {'nova': 	
		stage => comptnodejob2,
	}

	class {'neutron': 
		stage => comptnodejob3,
	}

}