class cinder::install inherits cinder{

	if $nodetype == 'cntrnode' {
		package { ["cinder-api"],["cinder-scheduler"]:
			ensure => installed,
		}
	} 
	elsif $nodetype == 'blocknode'{
		package { ["lvm2"],["cinder-volume"]:
			ensure => installed,
		}
	}
}