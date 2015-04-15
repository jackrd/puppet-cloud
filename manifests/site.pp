node 'puppetmaster.iec.inventec' {
 file { '/tmp/hello':
                content => "Deploy a pxe server and a router(as Firewall) for accessing public network\n",
        }

}

node 'cntrnode.iec.inventec' {

	class openstack {
		nodetype => 'cntrnode',
	}

}

node 'networknode.iec.inventec' {
	
	class openstack {
		nodetype => 'networknode',
	}


}

node 'comptnode.iec.inventec' {
	
	class openstack {
		nodetype => 'comptnodenode',
	}

}

