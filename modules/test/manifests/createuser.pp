define test::createuser ($username,$password) {

	$name1=$username

	exec {'runrun':
		command => "/bin/echo create ${name}, user=${username}, password=${password} > /tmp/${name1}",

	}
}