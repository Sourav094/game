
set ns [new Simulator]
set tf [open n3.tr w]
$ns trace-all $tf

set nf [open n3.nam w]
$ns namtrace-all $nf



set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]

$n0 color "red"
$n1 color "red"
$n2 color "red"
$n3 color "red"
$n4 color "red"
$n5 color "magenta"
$n6 color "magenta"
$n7 color "magenta"
$n8 color "magenta"
$n9 color "magenta"

$n0 label "TCPSOURCE"
$n2 label "UDPSOURCE"
$n4 label "Error node"
$n7 label "Null"
$n9 label "Sink"

$ns make-lan "$n0 $n1 $n2 $n3 $n4" 1Mb 10ms LL Queue/DropTail Mac/802_3
$ns make-lan "$n5 $n6 $n7 $n8 $n9" 1Mb 10ms LL Queue/DropTail Mac/802_3

$ns duplex-link $n4 $n5 5Mb 30ms DropTail
$ns duplex-link-op $n4 $n5 orient right-down
set err [new ErrorModel]
$ns lossmodel $err $n4 $n5
$err set rate_ 0.1

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
set sink9 [new Agent/TCPSink]
$ns attach-agent $n9 $sink9
$ns connect $tcp0 $sink9

$tcp0 set class_ 1
$tcp0 set packetSize_ 1000
$ftp0  set interval_ 0.01

set udp2 [new Agent/UDP]
$ns attach-agent $n2 $udp2
set cbr2 [new Application/Traffic/CBR]
$cbr2 attach-agent $udp2
set null7 [new Agent/Null]
$ns attach-agent $n7 $null7
$ns connect $udp2 $null7
$udp2 set class_ 2
$udp2 set packetSize_ 1000
$cbr2  set interval_ 0.01

$ns at 1.0 "$ftp0 start"
$ns at 1.0 "$cbr2 start"
$ns at 80.0 "$cbr2 stop"
$ns at 80.0 "$ftp0 stop"
$ns at 90.0 "finish"


proc finish { } {
global ns nf tf
$ns flush-trace
close $nf
close $tf
exec nam n3.nam &
exec awk -f n31.awk n3.tr &
exit 0
}
$ns run


























