set ns [new Simulator]
set tracefile [open out.tr w]
$ns trace-all $tracefile
set namfile [open out.nam w]
$ns namtrace-all $namfile
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
$ns duplex-link $n0 $n1 100Mb 10ms DropTail
$ns queue-limit $n0 $n1 50
$ns duplex-link $n0 $n2 100Mb 10ms DropTail
$ns queue-limit $n0 $n2 50
$ns duplex-link $n0 $n3 100Mb 10ms DropTail
$ns queue-limit $n0 $n3 50
$ns duplex-link $n1 $n2 100Mb 10ms DropTail
$ns queue-limit $n1 $n2 50
$ns duplex-link $n1 $n4 100Mb 10ms DropTail
$ns queue-limit $n1 $n4 50
$ns duplex-link $n2 $n4 100Mb 10ms DropTail
$ns queue-limit $n2 $n4 50

#$ns duplex-link-op $n0 $n1 orient right
#$ns duplex-link-op $n0 $n2 orient right-down
#$ns duplex-link-op $n0 $n3 orient down
#$ns duplex-link-op $n1 $n2 orient left-down
#$ns duplex-link-op $n1 $n4 orient down
#$ns duplex-link-op $n2 $n4 orient right-down

$ns cost $n0 $n1 5
$ns cost $n0 $n2 2
$ns cost $n0 $n3 5
$ns cost $n1 $n2 4
$ns cost $n1 $n4 3
$ns cost $n2 $n4 4

set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0

set null [new Agent/Null]
$ns attach-agent $n4 $null
$udp0 set packetSize_ 1500
$ns connect $udp0 $null
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0

$cbr0 set packetSize_ 1000
$cbr0 set rate_ 1Mb
$ns at 1.0 "$cbr0 start"
$ns at 5.0 "$cbr0 stop"
$ns rtproto LS


proc finish { } {
global ns tracefile namfile
$ns flush-trace
close $tracefile
close $namfile
exec nam out.nam &
exec awk -f n10.awk out.tr &
exit 0
}
$ns at 10.0 "$ns nam-end-wireless 10.0"
$ns at 10.0 "finish"
$ns run











