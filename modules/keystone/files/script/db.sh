#!/usr/bin/expect -f

set username [lindex $argv 0];
set passwd [lindex $argv 1];
set db_name [lindex $argv 2];
set db_passwd [lindex $argv 3];

set timeout 1
spawn mysql -u $username -p$passwd

#expect "mysql>"
#send "DROP DATABASE $db_name;\r"

expect "mysql>"
send "CREATE DATABASE $db_name;\r"
send "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_name'@'localhost' IDENTIFIED BY '$db_passwd';\r"
send "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_name'@'%' IDENTIFIED BY '$db_passwd';\r"

expect eof

return 0
