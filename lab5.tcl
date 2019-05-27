#simulate simple ESS and with transmitting nodes in wireless LAN by simulation and #determine the performance with respect transmission of packets.

set ns [new Simulator]

set tf [open lab5.tr w]
$ns trace-all $tf

set topo [new Topography]
$topo load_flatgrid 1000 1000
set nf [open lab5.nam w]
$ns namtrace-all-wireless $nf 1000 1000

$ns node-config -adhocRouting AODV \
-llType LL \
-macType Mac/802_11 \
-ifqType Queue/DropTail \
-ifqLen 50 \
-phyType Phy/WirelessPhy \
-channelType Channel/WirelessChannel \
-propType Propagation/TwoRayGround \
-antType Antenna/OmniAntenna \
-topoInstance $topo \
-agentTrace ON \
-routerTrace ON

create-god 4

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$n0 label "tcp0"
$n1 label "sink0"
$n2 label "tcp1"
$n3 label "sink1"

$ns at 0.1 "$n0 setdest 50 50 0"
$ns at 0.1 "$n1 setdest 700 700 0"
$ns at 0.1 "$n2 setdest 100 100 25"
$ns at 0.1 "$n3 setdest 800 800 25"

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
set sink1 [new Agent/TCPSink]
$ns attach-agent $n1 $sink1
$ns connect $tcp0 $sink1

set tcp1 [new Agent/TCP]
$ns attach-agent $n2 $tcp1
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
set sink2 [new Agent/TCPSink]
$ns attach-agent $n3 $sink2
$ns connect $tcp1 $sink2

$ns at 5 "$ftp0 start"
$ns at 5 "$ftp1 start"
$ns at 100 "$n1 setdest 550 550 15"
$ns at 190 "$n3 setdest 70 70 15"

proc finish { } {
global ns nf tf
$ns flush-trace
exec nam lab5.nam &
exec awk -f lab5.awk lab5.tr &
close $tf
exit 0
}
$ns at 250 "finish"
$ns run


