$fn = 20;

AT = 2; /* additional thickness */
W = 20.5; /* width */
L = 45; /* length */
HDIS = 20; /* hole distance */
HDIA = 3; /* hole diameter */
CSDI = 6; /* counter sink diameter */
CSDE = 4; /* counter sink depth */

difference() {
    union() {
        translate([14.5,28,0]) import("Arduino-Nano-Mount.stl");
        /* Source of Arduino-Nano-Mount.stl:
         * "Arduino Nano Mount" by tjbn on thingiverse
         * CC by-nc
         * https://www.thingiverse.com/thing:2336955
         */
        translate([0,0,-AT]) cube([W,L,AT]);
    }
    for (i = [-1, 1]) {
        translate([W/2,L/2 + i*HDIS/2,0]) {
            translate([0,0,-AT]) cylinder(d=HDIA, h=AT+1.5);
            translate([0,0,-CSDE+1.5]) cylinder(d1=0, d2=CSDI, h=CSDE);
        }
    }
}