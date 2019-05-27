set val(stop) 10.0;

set ns [new Simulator]

set nf [open n6.nam w]
$ns namtrace-all $nf

set tf [open n6.tr w]
$ns trace-all $tf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]

$ns duplex-link $n0 $n1 100.0Mb 10ms DropTail
$ns queue-limit $n0 $n1 50
$ns duplex-link $n0 $n2 100.0Mb 10ms DropTail
$ns queue-limit $n0 $n2 50 
$ns duplex-link $n2 $n3 100.0Mb 10ms DropTail
$ns queue-limit $n2 $n3 50
$ns duplex-link $n1 $n3 100.0Mb 10ms DropTail
$ns queue-limit $n1 $n3 50
$ns duplex-link $n0 $n4 100.0Mb 10ms DropTail
$ns queue-limit $n0 $n4 50
$ns duplex-link $n1 $n2 100.0Mb 10ms DropTail
$ns queue-limit $n1 $n2 50

$ns duplex-link-op $n0 $n1 orient right
$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n2 $n3 orient right-down
$ns duplex-link-op $n1 $n3 orient down
$ns duplex-link-op $n0 $n4 orient down
$ns duplex-link-op $n1 $n2 orient left-down

$ns cost $n0 $n1 5
$ns cost $n0 $n2 2
$ns cost $n0 $n4 4

$ns cost $n1 $n0 5
$ns cost $n1 $n2 4
$ns cost $n1 $n3 3

$ns cost $n2 $n1 4
$ns cost $n2 $n0 2
$ns cost $n2 $n3 10

$ns cost $n3 $n2 10
$ns cost $n3 $n1 3

$ns cost $n4 $n0 4

set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set null [new Agent/Null]
$ns attach-agent $n3 $null
$ns connect $udp0 $null
$udp0 set packetSize_ 1500

set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0
$cbr0 set packetSize_ 1000
$cbr0 set rate_ 1.0Mb
$cbr0 set random_ null
$ns at 1.0 "$cbr0 start"
$ns at 9.0 "$cbr0 stop"

$ns rtproto LS

proc finish {} {
global nf ns tf
$ns flush-trace
close $tf
close $nf
exec nam n6.nam &
exec awk -f n6.awk n6.tr &
exit 0
exit 0
}

$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts\"done\" ;
$ns halt"
$ns run

