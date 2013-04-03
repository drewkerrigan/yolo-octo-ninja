import pxssh
import getpass

def execute_command(username, password, hostname, command, password=1):
    try:
        s = pxssh.pxssh()
        s.login (hostname, username, password)
        
        print "Repl Leader: "
        
        s.sendline ('riak-repl status | grep "leader: \'"')
        s.expect(["password for " + username + ":"])
        s.sendline (password)
        s.prompt()
        print s.before
        
        print "Riak Ping: "
        
        s.sendline ('riak ping')
        s.prompt()
        print s.before
        
        print "Disk Space: "
        
        s.sendline ('du --max-depth=1 -h /var/lib/riak/')
        s.prompt()
        print s.before
        
        s.logout()
    except pxssh.ExceptionPxssh, e:
        print "pxssh failed on login."
        print str(e)

all_riak_nodes = [line.strip() for line in open("/opt/all_riak_nodes.txt", 'r')]
password = getpass.getpass('password: ')

for node in all_riak_nodes:
    print "Executing [" + command + "] on " + node
    execute_command("T7UL", password, node)