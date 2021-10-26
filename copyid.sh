#!/usr/bin/expect
spawn ssh-copy-id -i /home/$env(USER)/.ssh/id_rsa $env(USER)@$env(HOSTNAME)
expect "*yes/no"
send "yes\n"
expect "*password"
send "10000\n"
expect eof
