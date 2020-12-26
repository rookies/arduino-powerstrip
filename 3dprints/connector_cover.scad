$fn = 20;

CHD = 8; /* connector hole diameter */
W1 = 30; /* outer width */
H1 = 20; /* outer height */
T1 = 1; /* outer thickness */
D2 = 14; /* inner diameter */
T2 = 2; /* inner thickness */
SHD = 3; /* screw hole diameter */
SHO = 11; /* screw hole center offset */

difference() {
    translate([-W1/2,-H1/2]) union() {
        /* outer plate: */
        cube([W1,H1,T1]);
        /* inner plate: */
        translate([W1/2,H1/2]) cylinder(d=D2, h=T2);
    }
    /* connector hole: */
    cylinder(d=CHD, h=T2);
    /* screw holes: */
    for (i = [-1,1]) {
        translate([i*SHO,0]) cylinder(d=SHD, h=T2);
    }
}