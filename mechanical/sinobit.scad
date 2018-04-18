$fn= 32;
w_sinobit= 92.075;
t_sinobit= 1.4;
chole_sinobit= 42.8;
rhole_sinobit= 2.286;
rmiter_sinobit= w_sinobit/2-chole_sinobit;

echo(rmiter_sinobit);

module holes(c, r)
{
    rpos= c/cos(22.5);
    for(p=[22.5:45:360-22.5])
    {
        translate([rpos*cos(p),rpos*sin(p)]){circle(r);}
    }
}

module sinobit(w,chole,rhole,rmiter)
{
    c= w/2;
    s= w*tan(22.5)/2;
    cm= c/(cos(22.5)*cos(22.5))-rmiter+2.7;
    difference()
    {
        union()
        {
            intersection()
            {
                polygon([[c,s],[s,c],[-s,c],[-c,s],[-c,-s],[-s,-c],[s,-c],[c,-s]]);
                polygon([for(p=[0:45:315]) [cm*cos(p),cm*sin(p)]]);
            }
            holes(c=chole,r=rmiter);
        }
        holes(c=chole,r=rhole);
    }
}

module sinobit3D(w, c, r, rm, t)
{
    linear_extrude(height=t, center=true){sinobit(w, c, r, rm);}
}

sinobit3D(w_sinobit, chole_sinobit, rhole_sinobit, rmiter_sinobit, t_sinobit);