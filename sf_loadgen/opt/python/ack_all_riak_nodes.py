import pxssh
import getpass

def execute_command(username, password, hostname, command, password=1):
    try:
        s = pxssh.pxssh()
        s.login (hostname, username, password)
        s.sendline (command)
        if(password == 1):
            s.expect(["password for " + username + ":"])
            s.sendline (password)
        s.prompt()
        print s.before
        s.logout()
    except pxssh.ExceptionPxssh, e:
        print "pxssh failed on login."
        print str(e)

all_riak_nodes = [line.strip() for line in open("/opt/all_riak_nodes.txt", 'r')]
command = 'riak-repl status | grep "leader: \'"'
password = getpass.getpass('password: ')

for node in all_riak_nodes:
    print "Executing [" + command + "] on " + node
    execute_command("T7UL", password, node, command, 1)