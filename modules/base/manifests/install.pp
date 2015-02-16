class base::install {
	package { ["ntp", "expect", "mysql-server","python-mysqldb", "rabbitmq-server"]:
		ensure => installed,
	}

}