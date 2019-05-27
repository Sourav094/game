#Creating a Simulator Object
set ns [new Simulator]

#Setting up files for trace & NAM
set traceFile [open out.tr w]
set namFile   [open out.nam w]

#Tracing files using their commands
$ns trace-all $traceFile
$ns namtrace-all $namFile

#Creating NODES
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

#Label the nodes
$n0 label "TCP Source"
$n1 label "UDP Source"
$n2 label "Router"
$n3 label "Sink/Null"

#Creating LINKS

$ns duplex-link $n0 $n2 100Mb   20ms DropTail 
$ns queue-limit $n0 $n2 20
$ns duplex-link $n1 $n2 100Mb   20ms DropTail
$ns queue-limit $n1 $n2 20
$ns duplex-link $n2 $n3 100Mb   20ms DropTail
$ns queue-limit $n2 $n3 20 

#Node position for NAM
$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient right

#TCP Agent
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0

set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink

$ns connect $tcp0 $sink

#FTP over TCP connection
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

#TCP Agent
set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1

set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink

$ns connect $tcp1 $sink


#FTP over TCP connection
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1


$ns at 0.1 "$ftp0 start"
$ns at 0.1 "$ftp1 start"
$ns at 8.0 "$ftp0 stop"
$ns at 8.0 "$ftp1 stop"
$ns at 10.0 "finish"



#Closing trace file and starting NAM
proc finish { } {
	global ns traceFile namFile 
	$ns flush-trace
	close $traceFile
	close $namFile
	exec nam out.nam &
	exec awk -f n1.awk out.tr &
	exit 0 
}

# Initiate the simulation ....
$ns run
