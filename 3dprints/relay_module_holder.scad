/*
 * Holder for a “8 Relay Module”
 *
 * All measurements in mm.
 */

$fn = 20;

/* main dimensions (width, depth, height): */
W = 142;
D = 60;
H = 1;

/* screw hole distances (center to center, along X and Y axis): */
HDX = 133;
HDY = 51;

/* screw hole diameter: */
HD = 3;

/* spacer dimensions: */
SW = 11;
SD = 8;
SH = 4;

difference() {
    union() {
        /* main body: */
        cube([W,D,H], center=true);
        /* spacers: */
        for (i = [1,-1], j = [1,-1]) {
            translate([i*(W-SW)/2,j*(D-SD)/2,SH/2+H/2]) cube([SW,SD,SH], center=true);
        }
    }
    /* screw holes: */
    for (i = [1,-1], j = [1,-1]) {
        translate([i*HDX/2,j*HDY/2,SH/2]) cylinder(d=HD, h=H+SH, center=true);
    }
}
