$fn= 32;
w_sinobit= 92.075;
t_sinobit= 1.4;
chole_sinobit= 42.8;
rhole_sinobit= 2.286;
rmiter_sinobit= 3.2375;

echo(tan(22.5));

module holes(c, r)
{
    rpos= c/cos(22.5);
    for(p=[22.5:45:360-22.5])
    {
        translate([rpos*cos(p),rpos*sin(p)]){circle(rhole_sinobit);}
    }
}

module sinobit(w,chole,r)
{
    c= w/2;
    s= w*tan(22.5)/2;
    difference()
    {
        polygon([[c,s],[s,c],[-s,c],[-c,s],[-c,-s],[-s,-c],[s,-c],[c,-s]]);
        holes(chole,r);
    }
}

module sinobit3D(w, c, r, t)
{
    linear_extrude(height=t, center=true){sinobit(w, c, r);}
}

sinobit3D(w_sinobit, chole_sinobit, rhole_sinobit, t_sinobit);