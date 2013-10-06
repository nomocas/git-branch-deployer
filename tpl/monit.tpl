check process { name } with pidfile { root }/node.pid
    start program = "{ root }/start.sh"
    stop program  = "{ root }/stop.sh"
    if failed port { port } protocol HTTP
        request /
        with timeout 5 seconds
        then restart
