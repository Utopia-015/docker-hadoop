#!/usr/bin/expect
spawn ssh-copy-id -i /home/hadoop/.ssh/id_rsa hadoop@$env(HOSTNAME)
expect "*yes/no"
send "yes\n"
expect "*password"
send "10000\n"
expect eof
