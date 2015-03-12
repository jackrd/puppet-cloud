[Deployment]
Hardware Prerequisite:	
		1.Need at least three nodes: cntrnode/networknode/comptnode.
		2.Cntrnode needs two nic ports: eth0/em1 for management network, eth1/em2 for public network(used for access dashboard).
		3.Networknode needs three nic ports : eth0/em1 for management network, eth1/em2 for tunnel network, ethe2/em3 for external network.
		4.Comptnode needs two nic ports : eth0/em1 for management network, eth1/em2 for tunnel network.

Software 1rerequisite: 	
		1. Install ubuntu14.04.1 LTS to nodes by PXE Server.
	 	2. Install puppet-master package on Deploy Server.
		3. Install puppet client package on nodes.
		4. Signing nodes to puppet-master server.

Start Deployment:

		1. Setup /etc/hosts so we are able to ping nodes by hostname and use hostname in site.pp.
		2. Writeing site.pp (see manifests/site.pp)
		3. Run puppet agent -t on nodes to apply the deployment.


[Module Introduction]

base - 1. Install ntp,mysql and rabbitmq server
       2. Setup /etc/hosts, /etc/network/interfaces, create database for all service on cntrnode,
       3. Create setuprc.sh in /tmp/env/ so user can pass parameters helping us to generate correct .conf file for all services
