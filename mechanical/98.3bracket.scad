$fn=64;
l= 168.2; 
w= 29.9;
l1= 69.25;
w1= 9.5;
d= 3.5;
l2= 4;
w2= 7.5;

// Glaskasten
radstand= 36.8;
sInnen= 14;
sAussen= 16.3;
dAussen= 10.9;
dSpurkranz= 14;

lSchleifer= 68;
wSchleifer= 7;

sMitte= (sInnen+sAussen)/2;
b= sAussen-sInnen;
c= 2*sqrt(pow(dSpurkranz/2,2)-pow(dAussen/2,2));

module schleiferoeffnung()
{
    square([wSchleifer,lSchleifer],center=true);
}

module radoeffnung()
{
    square([b,c],center=true);
}

module raeder()
{
    union()
    {
        for (ll= [-1,1])
        {
            for (ww= [-1,1])
            {
                translate([ww*sMitte/2,ll*radstand/2]) radoeffnung();
            }
        }
    }
}

module holes()
{
    union()
    {
        for (ww= [-1,1])
        {
            for (ll= [-1,1])
            {
                translate([w1*ww, l1*ll]) circle(d= d);
            }
            translate([w2*ww, l2]) circle(d= d);
        }
    }
}

difference()
{
    square(size=[w,l],center=true);
    holes();
    raeder();
    schleiferoeffnung();
}
