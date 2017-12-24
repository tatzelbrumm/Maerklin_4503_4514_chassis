$fn=64;
m= 3;       // thickness of material

l= 168;     // length of bracket
w= 28;      // width of crossbeam
l1= 69.25;  // length of mounting hole center to car center
l2= 10;     // length of crossbeams center to car center
l3= 30;     // length of crossbeams center to car center
d= 3.5;     // mounting hole diameter
hn= 2;      // depth of feet
h0= 5;      // minimum height
h1= 20;     // maximum height
lk= 25;     // length of height transition
w1= 9.5;    // half width of mounting holes
wk= 2;      // width of height transition
h2= 10;     // depth of longbracket mounting notch
h3= 10;     // depth of crossbeam mounting notch

module longnotch()
{
    square([h2,m],center=true);
}

module longbracket()
{
    difference()
    {
        polygon(points=[[0,-l/2],
            [0,-l1-d/2],[-hn,-l1-d/2],[-hn,-l1+d/2],[0,-l1+d/2],
            [0,l1-d/2],[-hn,l1-d/2],[-hn,l1+d/2],[0,l1+d/2],
            [0,l/2],
            [h0,l/2],[h1,l/2-lk],[h1,-l/2+lk],[h0,-l/2]]);
        translate([h1-h2/2,-l2]) longnotch();
        translate([h1-h2/2,l2]) longnotch();
        translate([h1-h2/2,-l3]) longnotch();
        translate([h1-h2/2,l3]) longnotch();
    }
}

module crossnotch()
{
    square([m,h3],center=true);
}

module crossbeam()
{
    difference()
    {
        polygon(points=[[-w/2,0],[w/2,0],
            [w/2,h0],[w/2-wk,h1],[-w/2+wk,h1],[-w/2,h0]]);
        translate([w1,h3/2]) crossnotch();
        translate([-w1,h3/2]) crossnotch();
    }
}

module longbrackets()
{
    translate([-5,0]) mirror([1,0]) longbracket();
    translate([5, 0]) longbracket();
}

module crossbeams()
{
    translate([0,-5]) mirror([0,1]) crossbeam();
    translate([0,5]) crossbeam();
}

longbrackets();
translate([0,l/2+h1+10]) crossbeams();
translate([0,-l/2-h1-10]) crossbeams();

