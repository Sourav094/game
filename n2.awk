




BEGIN{
	cbrpkt=0;
	tcpsent=0;
	tcprecv=0;
}

{
	# Count number of CBR packets received...
	if(($1 == "r")&&($5 == "cbr")) &&($4 == "3"))
{
		cbrpkt = cbrpkt + 1; 
	}

	# Count number of TCP packets received by DEST ...
	if(($1 == "r")&&($5 == "tcp") &&($4 == "3")) {
		tcpsent = tcpsent + 1;
	}

	# Count number of TCP ACK packets received by SOURCE ...
	if(($1 == "r")&&($5 == "ack") &&($4 == "0")) 
	{
		tcprecv = tcprecv + 1;
	}
}
END{
	printf "\nNo. of CBR Packets being sent %d", cbrpkt;
	printf "\nNo. of TCP Packets being sent %d\n", tcpsent;
	printf "\nNo. of ACK Packets Received  %d\n", tcprecv;
}

