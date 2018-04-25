$fn=64;
/*
 * sino:bit definition
 */
w_sinobit= 92.075;
t_sinobit= 1.4;
chole_sinobit= 42.8;
rhole_sinobit= 2.286;
rmiter_sinobit= w_sinobit/2-chole_sinobit;

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
    echo(c,s);
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
/*
 * end sino:bit definition
 */

m= 3;       // thickness of material

w_sha= 12;  // width of SHA2017 badge with battery

l= 168;     // length of bracket
w= 28;     // width of crossbeam
l1= 69.25;  // length of mounting hole center to car center
l2= (w_sinobit-m)/2-5;  // length of crossbeams center to car center
l3= 2;      // length of full height beyond crossbeam notches
d= 3.5;     // mounting hole diameter
hn= 2;      // depth of feet
h0= 8;      // minimum height
h0_sinobit= 4;  // height clearance of sinobit PCB
h1= w_sinobit*(cos(22.5)-sin(22.5))/2+h0_sinobit;     // maximum height
lk= l/2-l2-4;  // length of height transition
lk2= h1-h0_sinobit;    // length of internal height transition 
l4= l2-lk2-l3-m;
w1= 9.5;    // half width of mounting holes
wk= 2;      // width of height transition
h2= h1/2;      // depth of longbracket mounting notch
h3= h1/2;      // depth of crossbeam mounting notch
h4= h0/2;
h5= h0/2;

h0d_sha= 2; // notch depth offset due to curvature
h1_sinobit= 4;   // depth of SHA2017 badge mounting notch
w1_sha= (w_sha-t_sinobit)/2; // center position of SHA2017 slot

w_cable= 2*w1-m-4;
h_cable= 2;



module sinonotch()
{
    square([t_sinobit,h1_sinobit],center=true);
}

module sinoshortnotch()
{
    square([t_sinobit,h0-h0_sinobit],center=true);
}

module sinocut()
{
    lc= l2-m/2;
    lt= lc-l3;
    lb= lt-lk2;
    polygon(points=[[h0,-lb],[h0,lb],
        [h1,lt],[h1,lc],[h1,-lc],[h1,-lt]]);
}

module longnotch()
{
    square([h2,m],center=true);
}

module shortnotch()
{
    square([h4,m],center=true);
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
        translate([h0-h4/2,-l4]) shortnotch();
        translate([h0-h4/2,l4]) shortnotch();
        sinocut();
    }
}

module crossnotch()
{
    square([m,h3],center=true);
}

module lownotch()
{
    square([m,h5],center=true);
}

module cablenotch()
{
    square([w_cable,h_cable],center=true);
}

module crossbeam()
{
    difference()
    {
        polygon(points=[[-w/2,0],[w/2,0],
            [w/2,h0],[w/2-wk,h1],[-w/2+wk,h1],[-w/2,h0]]);
        translate([w1,h3/2]) crossnotch();
        translate([-w1,h3/2]) crossnotch();
        translate([w1_sha,h1-h1_sinobit/2]) sinonotch();
        translate([0,h_cable/2]) cablenotch();
    }
}

module lowbeam()
{
    difference()
    {
        polygon(points=[[-w/2,0],[w/2,0],[w/2-wk,h0],[-w/2+wk,h0]]);
        translate([w1,h5/2]) lownotch();
        translate([-w1,h5/2]) lownotch();
        translate([w1_sha,h0-h0_sinobit/2]) sinoshortnotch();
        translate([0,h_cable/2]) cablenotch();
    }
}

module longbracket3D(t)
{
    linear_extrude(height=t, center=true) longbracket();
}

module crossbeam3D(t)
{
    linear_extrude(height=t, center=true) crossbeam();
}

module lowbeam3D(t)
{
    linear_extrude(height=t, center=true) lowbeam();
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

module lowbeams()
{
    translate([0,-2]) mirror([0,1]) lowbeam();
    translate([0,2]) lowbeam();
}

%longbrackets();
%translate([0,l/2+h1+4]) crossbeams();
%translate([0,-l/2-h0-4]) lowbeams();

module longbrackets3D(w)
{
    for (p=[-w,w])
        translate([p,0,0]) rotate([0,-90,0]) longbracket3D(m);
}

module crossbeams3D(l)
{
    for (p=[-l,l])
        translate([0,p,0]) rotate([90,0,0]) crossbeam3D(m);
}

module lowbeams3D(l)
{
    for (p=[-l,l])
        translate([0,p,0]) rotate([90,0,0]) lowbeam3D(m);
}

longbrackets3D(w1);
crossbeams3D(l2);
lowbeams3D(l4);


%translate([0,0,w_sinobit/2+h0_sinobit]) rotate([0,90,0])
{
    sinobit3D(w_sinobit, chole_sinobit, rhole_sinobit, rmiter_sinobit, t_sinobit);
}
