BEGIN{
cbrpack =0;
}
{
if(($1 =="r") && ($4 =="4") && ($5 =="cbr"))
{
cbrpack++;
}
}
END{
printf("\n\nTotal number of data packetat node 5 due to link state algorithm= %d",cbrpack);
}

