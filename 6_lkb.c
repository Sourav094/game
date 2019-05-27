/*###############################################
# Name : Nataraju A B
#        Assistant Professor,
#			Dept. of ECE, AIT, Bangalore
############################################### */



#include<stdio.h>
int min(int x,int y)
{
    if(x<y)
        return x;
    else
        return y;
}

int main()
{
	int drop=0,mini,nsec,cap,count=0,i,inp[25],process; // note count is a local variable
	printf("Enter bucket size :");
	scanf("%d",&cap);//  cap =size of bucket

	printf("Enter transmission rate :");
	scanf("%d",&process);//process=  rate of transmission

	printf("Enter The duration of simulation in seconds : ");
	scanf("%d",&nsec);//nsec = duration of simulation in seconds

	for(i=0;i<nsec;i++)
	{
		printf("Enter packet size at %d sec : ",i+1);
		scanf("%d",&inp[i]);//inp = input packet size
	}

	printf("\nSecond|Packet Recieved|Packet Sent|Packet Left|Packet Dropped|\n");///main stuff to remember
	printf("--------------------------------------------------------------\n");

	for(i=0;i<nsec;i++)
	{
		count+=inp[i]; // initaializing the packet size to the first packet
		if(count>cap)  // checking if the overall packet size  is greater than the bucket size
		{
			drop=count-cap;// if true this would lead to drop in packet
			count=cap;     // count value is  set to bucket size
		}
		printf("%d",i+1);  // printing the second
		printf("\t%d",inp[i]);// printing the input size
		mini=min(count,process);//checking which is smaller the bucket size or the rate of transmission
		printf("\t\t%d",mini);// printing the rate of transmission
		count=count-mini;//again seting the  count value  by deducting the transmited value not the transmission rate
		printf("\t\t%d",count);//packets left in the bucket
		printf("\t\t%d\n",drop);// printing the pre calulated value of the drop packets
		drop=0;// seting the drop packet  to zero
		sleep(1);// sleeping for a second
	}

	// below here the line of code is used to  send all the  packect even though the  time has elapsed
	for(;count!=0;i++)
	{
		if(count>cap)
		{
			drop=count-cap;
			count=cap;
		}
		printf("%d",i+1);
		printf("\t0");
		mini=min(count,process);
		printf("\t\t%d",mini);
		count=count-mini;
		printf("\t\t%d",count);
		printf("\t\t%d\n",drop);
		sleep(1);
	}
}
