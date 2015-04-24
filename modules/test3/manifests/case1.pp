class test3::case1 inherits test3{

	notify { "The value of nodetype4 : ${nodetype}": }
	notify { "The value of mGMT_NETIP_CONTROLLER4 : $mGMT_NETIP_CONTROLLER": }

	notify { "Run test3::case1": }

}