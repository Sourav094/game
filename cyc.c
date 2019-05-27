







#include<stdio.h>
#include<string.h>
int crc(char *input, char *output, const char *gp, int mode)
{
int j,k;
strcpy(output,input);
if(mode)
{
for(j=1; j<strlen(gp); j++)
strcat(output,"0");
}

for(j=0; j<strlen(input); j++)
if(*(output+j) == '1')
for(k=0 ;k<strlen(gp); k++)
{
if(((*(output+j+k)=='0') && (gp[k]=='0') || (*(output+j+k)=='1') && (gp[k]=='1')))
	*(output+j+k)='0';
else
	*(output+j+k)='1';
}

for(j=0;j<strlen(output);j++)
 if(output[j] == '1')
	return 1;
	return 0;
}

int main()
{
char input[50],output[50],recv[50];
const char gp[18]="1011";
//specification G(x):x^16+x^12+x^5+1;
printf("\n enter the input message in binary\n");
scanf("%s",input);
crc(input,output,gp,1);
printf("\n the transmitted message is %s%s\n",input,output+strlen(input));
printf("\n\n enter the received message in binary\n");
scanf("%s",recv);


if(!crc(recv,output,gp,0))
printf("\n no error in data\n");
else
printf("\n error in data transmission has occured\n");
return 0;
}

