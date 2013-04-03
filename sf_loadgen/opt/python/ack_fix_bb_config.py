riak_nodes = [line.strip() for line in open("/opt/bb_riak_nodes.txt", 'r')]
shim_nodes = [line.strip() for line in open("/opt/shim_nodes.txt", 'r')]
i = 0

print "{riakc_java_nodes, ["

for s in shim_nodes:
    for r in riak_nodes:
        i = i + 1
        line = "    {'" + s + "', {" + r + "}, 8087}" 
        line += "]}." if (i == len(riak_nodes) * len(shim_nodes)) else ","
        print line