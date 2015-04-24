class cinder::service inherits cinder{
		
	if $nodetype == 'cntrnode' {

		service { ["cinder-scheduler"],["cinder-api"]:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		}
	
	} 
	elsif $nodetype == 'blocknode' {

		service { ["cinder-volume","tgt"]:
			ensure => running,
			hasstatus => true,
			hasrestart => true,
			enable => true,
		}
	
	}
}