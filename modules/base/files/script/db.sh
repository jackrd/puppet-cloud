#!/usr/bin/expect -f

set db_passwd [lindex $argv 0];

set timeout 3
spawn mysql_secure_installation

#expect \"mysql>\"

expect "Enter current password for root (enter for none):"
send "$db_passwd\r"
 
expect "Change the root password?"
send "n\r"
 
expect "Remove anonymous users?"
send "y\r"
 
expect "Disallow root login remotely?"
send "y\r"
 
expect "Remove test database and access to it?"
send "y\r"
 
expect "Reload privilege tables now?"
send "y\r"
 
expect eof

return 0