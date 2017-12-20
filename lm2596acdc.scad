$fn=64;

l= 54;
w= 23;

l1=16.5;
w1=8.5;
d1=3;
dl=3.6;

module holes()
{
    union()
    {
        for (ll= [-1,1])
	{
	    translate([w1*ll, l1*ll+dl]) circle(d=d1);
	}
    }
}

difference()
{
    square(size=[w,l],center=true);
    holes();
}

