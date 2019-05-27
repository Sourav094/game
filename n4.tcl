

#Implement Ethernet LAN using n nodes and assign multiple traffic to the nodes and obtain congestion window for different sources/ destinations. 



#Create Simulator
set ns [new Simulator]

#Open trace and NAM trace file
set tracefile [open out.tr w]
$ns trace-all $tracefile

set namfile [open out.nam w]
$ns namtrace-all $namfile

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]

# Label the nodes 
$n0 label "SRC-1"
$n7 label "DST-1"

$n4 label "SRC-2"
$n3 label "DST-2"

# Create a LAN of nodes
$ns make-lan "$n0 $n1 $n2 $n3 $n4 $n5 $n6 $n7" 3Mb 30ms LL Queue/DropTail Mac/802_3

# Setup a pair of TCP sender and receiver (sender @ n0 , receiver @ n7)
set tcp1 [new Agent/TCP]
$ns attach-agent $n0 $tcp1
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

set sink1 [new Agent/TCPSink]
$ns attach-agent $n7 $sink1
$ns connect $tcp1 $sink1

# Setup another pair of TCP sender and receiver (sender @ n4, receiver @ n3)
set tcp2 [new Agent/TCP]
$ns attach-agent $n4 $tcp2
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

set sink2 [new Agent/TCPSink]
$ns attach-agent $n3 $sink2
$ns connect $tcp2 $sink2

$ftp1 set type_ FTP
$ftp2 set type_ FTP
$tcp1 set class_ 1
$tcp2 set class_ 2

set outfile1 [open congestion1.xg w]
set outfile2 [open congestion2.xg w]

# Populate the TCP window values and write to a file for later plotting
# procedure to plot the congestion window

$ns at 0.0 "plotwindow $tcp1 $outfile1"

proc plotwindow {tcpsource outfile} {
	global ns
	set curtime [$ns now]
	set curcwnd [$tcpsource set cwnd_]

# the data is recorded in a file called congestion.xg (this can be plotted 		
# using xgraph or gnuplot. 
# this example uses xgraph to plot the cwnd

	puts  $outfile  "$curtime $curcwnd"
	$ns at [expr $curtime+0.01] "plotwindow $tcpsource  $outfile"
}

$ns color 1 "red"
$ns color 2 "green"

# What to do at the end of simulation ???
proc finish { } {
	global ns tracefile namfile outfile1 outfile2
	$ns flush-trace
	close $tracefile
	close $namfile 

	exec xgraph congestion1.xg congestion2.xg -geometry 400x400 &
#		exec xgraph congestion1.xg  -geometry 400x400 &
#		exec xgraph congestion2.xg -geometry 400x400 &

	exit 0
}

$ns at 0.0 "plotwindow $tcp1 $outfile1"
$ns at 0.0 "plotwindow $tcp2 $outfile2"

$ns at 0.1  "$ftp1 start"
$ns at 0.1  "$ftp2 start"
$ns at 49.5 "$ftp1 stop"
$ns at 49.5 "$ftp2 stop"
$ns at 50.0 "finish"

# Start the simulation....
$ns run


