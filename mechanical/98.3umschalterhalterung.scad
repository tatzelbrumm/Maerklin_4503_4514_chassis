$fn=64;
m= .8;      // Materialdicke

l= 22.1;    // Laenge
w= 15.7;    // Breite
ls= 14.7;   // Laenge kurze Seite
ws= 14;     // Breite kurze Seite
l1= 13.8;   // Breite lange Wand
h= 5.8;     // volle Hoehe
hs= 4.1;    // kurze Hoehe
d= 2.5;

module bodenplatte()
{
    linear_extrude(height= m)
    difference()
    {
        square([l,ws]);
        translate([ls-d/2,0]) square([d,d]);
        translate([0,ws-d-m]) square([d+m,d]);
        translate([0,d]) square([2*m,ws-2]);
    }
}

module rueckwand()
{
    linear_extrude(height= m)
    square([l,h]);
}

module rechtewand()
{
    linear_extrude(height= m)
    square([ws,hs]);
}

module linkewand()
{
    linear_extrude(height= m)
    square([l1,h]);
}

module vorderwand()
{
    linear_extrude(height= m)
    square([ls,h]);
}

module kurzewand()
{
    linear_extrude(height= m)
    square([d,h]);
}

translate([0,w-ws,0]) bodenplatte();
translate([0,w,0]) rotate([90,0,0]) rueckwand();
translate([l-m,w-ws,0]) rotate([90,0,90]) rechtewand();
rotate([90,0,90]) linkewand();
translate([0,m,0]) rotate([90,0,0]) vorderwand();
translate([ws,0,0]) rotate([90,0,90]) kurzewand();
translate([0,l1,0]) rotate([90,0,0]) kurzewand();

/*
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
    translate([-wk-2,0]) mirror([1,0]) longbracket();
    translate([wk+2, 0]) longbracket();
}

module crossbeams()
{
    translate([0,-2]) mirror([0,1]) crossbeam();
    translate([0,2]) crossbeam();
}

longbrackets();
translate([h1+w/2+wk+4,h1+4]) crossbeams();
translate([h1+w/2+wk+4,-h1-4]) crossbeams();

*/