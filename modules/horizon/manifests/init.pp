class horizon {

	stage {'horizonJob1':
		before => stage['horizonJob2'],
	}
	stage {'horizonJob2':
		before => stage['horizonJob3'],
	}
	stage {'horizonJob3':
		before => stage['main'],
	}
	stage {'horizonJob4':
		require => stage['main'],
	}


	class {'horizon::install': stage=>horizonJob1,}
	class {'horizon::env': stage=>horizonJob2,}
	class {'horizon::config': stage=>horizonJob3,}
	class {'horizon::service': stage=>horizonJob4,}

	include horizon::install
	include horizon::env
	include horizon::config 
	include horizon::service
}