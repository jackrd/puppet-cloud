class openstack::cinder inherits openstack {

	stage {'blocknodejob1':
		before => Stage['main'],
	}

	stage {'blocknodejob2':
		require => Stage['main'],
	}


	class {'base': 	
		stage => blocknodejob1,
	}

	class {'cinder': 
		stage => blocknodejob2,
	}
}