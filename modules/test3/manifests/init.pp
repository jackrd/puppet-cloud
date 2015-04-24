class test3 inherits openstack {

	notify { "The value of nodetype3 : ${nodetype}": }
	notify { "The value of mGMT_NETIP_CONTROLLER3 : $mGMT_NETIP_CONTROLLER": }
	#notify { "Run test3": }

	stage {'test3Job1':
		before => stage['test3Job2'],
	}

	stage {'test3Job2':
		before => stage['test3Job3'],
	}

	stage {'test3Job3':
		before => stage['test3Job4'],
	}

	stage {'test3Job4':
		before => stage['main'],
	}

	stage {'test3Job5':
		require => stage['main'],
	}


	class {'test3::case1': stage=>test3Job1,}
	class {'test3::case2': stage=>test3Job2,}
	class {'test3::case3': stage=>test3Job3,}
	class {'test3::case4': stage=>test3Job4,}
	class {'test3::case5': stage=>test3Job5,}

	include test3::case1
	include test3::case2
	include test3::case3
	include test3::case4
	include test3::case5
}