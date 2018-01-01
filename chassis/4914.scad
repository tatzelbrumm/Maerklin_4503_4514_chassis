$fn=64;
l= 168.2; 
w= 29.9;
l1= 69.25;
w1= 9.5;
d= 3.5;
l2= 4;
w2= 7.5;

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
}
