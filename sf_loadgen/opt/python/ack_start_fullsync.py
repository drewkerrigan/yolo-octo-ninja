import pxssh
import getpass
 
def execute_command(username, password, hostname):
    try:
        s = pxssh.pxssh()
        s.login (hostname, username, password)
 
        print "Starting fullsync..."
        s.sendline ("riak-repl start-fullsync")
        s.expect(["password for " + username + ":"])
        s.sendline (password)
        s.prompt()
        print s.before
        print "Started fullsync..."
        
        fullsync_keys = [
            'Full-sync with site "sf31" completed',
            'Full-sync with site "sf21" completed'
            ]
        
        found_one = False
        found_two = False
        
        s.sendline ("tail -f -n0 /var/log/riak/console.log")
        
        while True:
            seen = s.expect(fullsync_keys,None)
            print fullsync_keys[seen]
            if seen == 0:
                found_one = True
            if seen == 1:
                found_two = True
            if found_one == True and found_two == True:
                break
        
        #kill the tail
        s.sendcontrol('c')
        s.prompt()
        s.logout()
    except pxssh.ExceptionPxssh, e:
        print "pxssh failed on login."
        print str(e)

password = getpass.getpass('password: ')
execute_command("T7UL", password, "riak0x56.test.statefarm.com")