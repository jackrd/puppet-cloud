node 'puppetmaster.iec.inventec' {

 	file { '/tmp/hello':
                content => "Deploy a pxe server and a router(as Firewall) for accessing public network\n",
        }

}

node 'cntrnode.iec.inventec' {

	hiera_include('classes')
}

node 'networknode.iec.inventec' {
	
	hiera_include('classes')
}

node 'comptnode.iec.inventec' {
	
	hiera_include('classes')
}

node 'blocknode.iec.inventec' {
	
	hiera_include('classes')
}



