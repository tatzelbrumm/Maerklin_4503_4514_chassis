w_sinobit= 92.075;
t_sinobit= 1.4;

echo(tan(22.5));

module sinobit(w)
{
    c= w/2;
    s= w*tan(22.5)/2;
    polygon([[c,s],[s,c],[-s,c],[-c,s],[-c,-s],[-s,-c],[s,-c],[c,-s]]);
}

module sinobit3D(w, t)
{
    linear_extrude(height=t, center=true){sinobit(w);}
}

sinobit3D(w_sinobit, t_sinobit);