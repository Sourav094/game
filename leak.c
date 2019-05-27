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
int drop=0,mini,nsec,cap,count=0,i,inp[25],process;

printf("enter bucket size :");
scanf("%d", &cap);
printf("enter transmission rate :");
scanf("%d", &process);
printf("enter the duration of simulation in seconds :");
scanf("%d", &nsec);
for(i=0;i<nsec;i++)
{
printf("enter packet size at %d sec :",i+1);
scanf("%d", &inp[i]);
}
printf("\n Second|packet Received|packet Sent|packet Left|packet Dropped|\n");
printf("-------------------------\n");
for(i=0;i<nsec;i++)
{
count+=inp[i];

if(count>cap)
{
drop=count-cap;
count=cap;
}
printf("%d",i+1);
printf("\t%d",inp[i]);
mini=min(count,process);
printf("\t\t%d",mini);
count=count-mini;
printf("\t\t%d",count);
printf("\t\t%d\n",drop);
drop=0;
sleep(1);
}

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


