class base::install {
	
	package { ["ntp", "expect", "python-mysqldb"]:
		ensure => installed,
	}

	if $nodetype == 'cntrnode' {

		package { "mysql-server":
			ensure => installed,
		}

		package { "rabbitmq-server":
			ensure => installed,
		}

	}

}