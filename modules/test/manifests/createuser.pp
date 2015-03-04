define test::createuser ($username,$password) {

	$name1=$username

	exec {'runrun':
		command => "/bin/echo create ${name}, user=${username}, password=${password} > /tmp/${name1}",

	}

	#exec {'runrun2':
	#	command => "ls -l /tmp/ttt | awk -F" " {'print $6'} ",
	#	path => ["/bin/","/usr/bin/"],
	#
	#}

}