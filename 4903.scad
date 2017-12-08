$fn=64;

l= 89.6; 
w= 29.0;

d1= 3;
d2= 2.4;
d3= 3.9;
l1= 18;
l2= 15;
l3= 29;
w2= 6.6;
w3= 8.5;

w4= 6.6;
w5= 6.7;
l4= 42;
l5= 37.5;

w6= 3;
w7= 3.1;
l6= 26.7;
l7= 21.85;

module holes()
{
    union()
    {
        for (ll= [-1,0,1])
        {
            translate([0, l1*ll]) circle(d= d1);
        }
        for (ww= [-1,1])
        {
            translate([w2*ww,0]) circle(d= d2);
            translate([w3*ww, l2*ww]) circle(d= d2);
            translate([w3*ww, -l2*ww]) circle(d= d3);
            translate([w3*ww, -l3*ww]) circle(d= d2);
            translate([w3*ww, l3*ww]) circle(d= d3);
        }
    }
}

module polygons()
{
    union()
    {
        for (ll= [-1,1])
        {
            polygon([[w4,l4*ll],[-w4,l4*ll],[-w5,l5*ll],[w5,l5*ll]]);
            polygon([[w6,l6*ll],[-w6,l6*ll],[-w7,l7*ll],[w7,l7*ll]]);
        }
    }
}

difference()
{
    square(size=[w,l],center=true);
    holes();
    polygons();
}