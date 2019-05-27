




# Implement a four node point to point network with links n0-n2, #n1-n2 and n2-n3. Apply TCP agent between n0-n3 and UDP #between n1-n3. Apply relevant applications over TCP and UDP #agents changing the parameter and determine the number of #packets sent by TCP/UDP.

#Create a new Simulation Instance
set ns [new Simulator]

#Setting up files for trace & Animation
set trfile  [open out.tr  w]
set namfile [open out.nam w]

#Tracing/Logging the simulation events into specified file.
$ns trace-all $trfile
$ns namtrace-all $namfile

#Create the nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

#Label the nodes
$n0 label "TCP SOURCE"
$n1 label "UDP SOURCE"
$n2 label "ROUTER"
$n3 label "SINK"

#Set the color for flows...
$ns color 1 red
$ns color 2 blue

#Create the Topology
$ns duplex-link $n0 $n2 1Mb     10ms DropTail
$ns duplex-link $n1 $n2 1Mb     10ms DropTail
$ns duplex-link $n2 $n3 1Mb     10ms DropTail

#Soecify size of Queue for the links between the nodes n2 n3
$ns queue-limit $n2 $n3 10

#Make the Link Orientation (for NAM only....)
$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient right

#Create a UDP Agent and attach to the node n1
set udp0 [new Agent/UDP]
$ns attach-agent $n1 $udp0

#Create a CBR Traffic source and attach to the UDP Agent
set cbr0 [new Application/Traffic/CBR] 
$cbr0 attach-agent $udp0

#Specify the Packet Size and interval
$cbr0 set packetSize_ 1500
$cbr0 set interval_ 0.1 

#Create a Null Agent and attach to the node n3
set null0 [new Agent/Null]
$ns attach-agent $n3 $null0

#### Connect the CBR Traffic source to the Null agent
$ns connect $udp0 $null0

#Create a TCP agent and attach to the node n0
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0

#Create a FTP source and attach to the TCP agent
set ftp0 [new Application/FTP]

#Attach the FTP source to the TCP Agent
$ftp0 attach-agent $tcp0

#Specify the Max no. of packets to send & Packet Size
$ftp0 set maxPkts_ 1000
$ftp0 set packetSize_ 1500

#Create a TCPSink agent and attach to the node n3
set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink

#### Connect the TCP Agent with the TCPSink
$ns connect $tcp0 $sink

$udp0 set class_ 1
$tcp0 set class_ 2

#Schedule the Events
$ns at 0.1 "$cbr0 start"
$ns at 0.1 "$ftp0 start"
$ns at 4.0 "$ftp0 stop"
$ns at 4.0 "$cbr0 stop"
$ns at 5.0 "finish"

#Define the finish procedure to perform at the end of the simulation
proc finish {} {
	global ns trfile namfile 
	$ns flush-trace
	close $trfile
	close $namfile	
	exec nam out.nam &
	exec awk -f n2.awk out.tr   &
	
	exit 0
}

# RUN the simulation....
$ns run

