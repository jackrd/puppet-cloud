[Deployment]
Pre: 	1. need at least three nodes: cntrnode/networknode/comptnode
	2. Install ubuntu14.04.1 LTS to nodes by PXE Server 
 	3. install puppet-master package on Deploy Server
	4. install puppet client package on nodes
	5. sing nodes to puppet-master server


1. setup /etc/hosts so we are able to ping nodes by hostname and use hostname in site.pp.
2. writeing site.pp (see manifests/site.pp)
3. run puppet agent -t on nodes to apply the deployment.


[Module Introduction]

base - 1. install ntp,mysql and rabbitmq server
       2. setup /etc/hosts, /etc/network/interfaces, create database for all service,
       3. create setuprc.sh in /tmp/env/ so user can pass parameters helping us to generate 	  correct xxx.conf file for all services
