#!/usr/bin/expect -f

set username [lindex $argv 0];
set passwd [lindex $argv 1];
set nova_db_name [lindex $argv 2];
set nova_db_passwd [lindex $argv 3];

set timeout 3
spawn mysql -u $username -p$passwd

#expect \"mysql>\"
#send "DROP DATABASE $db_name;\r"

expect \"mysql>\"
send "CREATE DATABASE $nova_db_name;\r"
send "GRANT ALL PRIVILEGES ON $nova_db_name.* TO '$nova_db_name'@'localhost' IDENTIFIED BY '$nova_db_passwd';\r"
send "GRANT ALL PRIVILEGES ON $nova_db_name.* TO '$nova_db_name'@'%' IDENTIFIED BY '$nova_db_passwd';\r"

expect eof

return 0
