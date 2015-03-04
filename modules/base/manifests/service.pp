class base::service {
	service { ["ntp"]:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
	}

	if $nodetype == 'cntrnode' {

		service { ["mysql"]:
			ensure => running,
			hasstatus => true,
			hasrestart => true,
			enable => true,
		}
		service { ["rabbitmq-server"]:
			ensure => running,
			hasstatus => true,
			hasrestart => true,
			enable => true,
		}

	}
}