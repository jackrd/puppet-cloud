class base {
	#include ::cntrnode::params

	stage {'baseJob1':
		before => stage['baseJob2'],
	}

	stage {'baseJob2':
		before => stage['baseJob3'],
	}

	stage {'baseJob3':
		before => stage['baseJob4'],
	}

	stage {'baseJob4':
		before => stage['main'],
	}

	stage {'baseJob5':
		require => stage['main'],
	}


	class {'base::install': stage=>baseJob1,}
	class {'base::env': stage=>baseJob2,}
	class {'base::dbsetting': stage=>baseJob3,}
	class {'base::config': stage=>baseJob4,}
	class {'base::service': stage=>baseJob5,}


	include base::install
	include base::env
	include base::dbsetting
	include base::config 
	include base::service
}