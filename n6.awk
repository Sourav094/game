BEGIN{
cbrpack=0
}
{
if($1=="r"&&$4=="3"&&$5=="cbr"&&$6=="1000")
{
cbrpack++;
}
}
END{
printf("\n total number of data packets at node 3 due to link state algorithm: %d\n", cbrpack);
}

