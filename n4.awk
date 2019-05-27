

# Following set of processing is performed once at the -START- of the  
# trace file post-processing....
BEGIN{
	totalpackets = 0;
	time=0;
	size = 500;
	Throughput = 0.0;
	cbrpkt = 0;
	tcppkt = 0;
}

# Following set of processing is repeated for each line in the 
# trace file....
{
	if(($1=="+") && ($3=="4") && ($4=="5") && ($5=="tcp") )
		tcppkt++;
	if(($1=="+") && ($3=="4") && ($4=="5") && ($5=="cbr") )
		cbrpkt++;
	time = $2;
}

# Following set of processing is performed once at the -END- of the  
# trace file post-processing....

END {
	totalPackets = tcppkt +cbrpkt;
	Throughput = (totalpackets*size*8)/(time*1000);
	printf("\n Total Packets sent from node 4 to 5 : %d \n", totalpackets);
	printf("\n The throughtput is     : %d kbps\n", throughput);
}

