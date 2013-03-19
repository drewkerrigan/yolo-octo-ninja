if version.find('1.2') != -1:
	match='''Full-sync with site "cluster2" completed'''
	command='riak-repl start-fullsync'
elif version.find('1.3') != -1:
	match='Fullsync complete'
	command='riak-repl fullsync start cluster2'