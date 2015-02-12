node 'puppet.iec.inventec' {
	file { '/tmp/hello':
			content => "Hello\n",
	}
}

node 'cntrnode.iec.inventec' {
	
	$var = '44'
	$var2 = '7777'
	$var3 = '77'

	$username = 'root'
	$passwd = '111111'
	$db_name = 'keystone'
	$db_passwd = '111111'

	include test

}


node 'netnode.iec.inventec' {

}

node 'computenode.iec.inventec' {

}

