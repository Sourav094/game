BEGIN{
	cbrpkt=0;
	tcppkt=0;
}

{
	
	if(($1 == "d")&&($5 == "tcp")) {
		tcppkt = tcppkt + 1;
	}
}

END {
	
	printf "\nNo. of TCP Packets Dropped %d\n", tcppkt;
}
