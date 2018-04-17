w_sinobit= 92.075;

echo(tan(22.5));

module sinobit(w)
{
    c= w/2;
    s= w*tan(22.5)/2;
    polygon([[c,s],[s,c],[-s,c],[-c,s],[-c,-s],[-s,-c],[s,-c],[c,-s]]);
}

sinobit(w_sinobit);