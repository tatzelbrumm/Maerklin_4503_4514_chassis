$fn=64;
m= 3;       // thickness of material

l_r0ket= 125;   // overall length of r0ket
l1_r0ket= 75;   // length between mounting stations
w_r0ket= 10+5-1.6; // width of r0ket (top of connector to bottom of battery)
wd_r0ket= 2.5;  // displacement of PCB from center line
h1_r0ket= 60.4; // height of r0ket at backward station
h0_r0ket= 47.4; // height of r0ket at forward station
t_r0ket= 1.4;   // thickness of r0ket PCB


l= 168;     // length of bracket
w= 28;      // width of crossbeam
l1= 69.25;  // length of mounting hole center to car center
w1= 9.5;    // half width of mounting holes
d= 3.5;     // mounting hole diameter
hn= 2;      // depth of feet

h0= 4;      // minimum height
h1= 16.4;     // forward station height
h2= 10;     // backward station height
l2= l1_r0ket/2;  // length of crossbeams center to car center
l3= 2;      // length of full height beyond crossbeam notches
lk1= h1;    // length of height transition, forward
lk2= h2;    // length of height transistion, backward
wk= 2;      // width of height transition
h3= 6;      // depth of forward mounting notch
h4= 6;      // depth of backward mounting notch

module longbracket()
{
    difference()
    {
        polygon(points=[[0,-l/2],
            [0,-l1-d/2],[-hn,-l1-d/2],[-hn,-l1+d/2],[0,-l1+d/2],
            [0,l1-d/2],[-hn,l1-d/2],[-hn,l1+d/2],[0,l1+d/2],
            [0,l/2],
            [h0,l/2],
            [h0,(l1_r0ket+m)/2+l3+lk1],
            [h1,(l1_r0ket+m)/2+l3], [h1,(l1_r0ket-m)/2-l3],
            [h0,(l1_r0ket-m)/2-l3-lk1],
            [h0,(-l1_r0ket+m)/2+l3+lk2],
            [h2,(-l1_r0ket+m)/2+l3], [h2,(-l1_r0ket-m)/2-l3],
            [h0,(-l1_r0ket-m)/2-l3-lk2],
            [h0,-l/2]]);
        translate([h1*3/4,l1_r0ket/2]) square([h1/2,m],center=true);
        translate([h2*3/4,-l1_r0ket/2]) square([h2/2,m],center=true);
    }
}

module crossnotch(h)
{
    square([m,h/2],center=true);
}

module crossbeam(h,hn,wd)
{
    difference()
    {
        polygon(points=[[-w/2,0],[w/2,0],
            [w/2,h0],[w/2-wk,h],[-w/2+wk,h],[-w/2,h0]]);
        translate([w1,h/4]) crossnotch(h);
        translate([-w1,h/4]) crossnotch(h);
        translate([wd,h-hn/2]) square([t_r0ket,hn],center=true);
    }
}

module longbrackets()
{
    translate([-wk-2,0]) mirror([1,0]) longbracket();
    translate([wk+2, 0]) longbracket();
}

module crossbeams()
{
    crossbeam(h1,h3,wd_r0ket);
    translate([0,h1+4]) crossbeam(h2,h4,-wd_r0ket);
}

longbrackets();
translate([0,l/2+4]) crossbeams();

