





BEGIN{
#include<stdio.h>
pkt1=0;
pkt2=0;
time1=0;
time2=0;
}
{
if($1=="r" && $9=="0.0" && $10=="9.0")
{
pkt1=pkt1+$6;
time1=$2;
}
if($1=="r" && $9=="2.0" && $10=="7.0")
{
pkt2=pkt2+$6;
time2=$2;
}
}
END{
printf"\n throughputtcp:%f  Mbps \n\n",(pkt1/time1)*(8/1000000);
printf"\n throughputudp:%f  Mbps \n\n",(pkt2/time2)*(8/1000000);
printf"\n throughput:%f  Mbps \n\n",((pkt1+pkt2)/(time1+time2))*(8/1000000);
}

