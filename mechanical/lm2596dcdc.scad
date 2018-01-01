$fn=64;

l= 43.3;
w= 21;

l1=15;
w1=8;
d1=3;

module holes()
{
    union()
    {
        for (ll= [-1,1])
	{
	    translate([w1*ll, l1*ll]) circle(d=d1);
	}
    }
}

difference()
{
    square(size=[w,l],center=true);
    holes();
}

