include <BOSL2/std.scad>
include <NopSCADlib/lib.scad>

// lead screw
nut_length=15;
nut_od=16;
nut_id=9;
nut_pitch=2;

// screw
screw_id=2.5;
screw_r=8;

// magnet
magnet_od=6.35;
magnet_height=2;

function nut_length() = nut_length;

module LowerBody(shaft_offset=18, shaft_od=3, bearing_id=10, bearing_od=18, bearing_tw=1.25, nut_lead=8) {
    margin=0.01;
    gap=0.1;
    color("dimgrey")
    difference() {
        // body
        union() {
            // nut
            xrot(180) let($show_threads = true) 
                leadnut([
                    "COUPLER8", 
                    "Leadscrew nut 8", 
                    nut_id, 
                    nut_od, 
                    nut_length, 
                    0, 0, 0, 1, 0, 8, M3_cap_screw, 
                    nut_pitch, 
                    nut_lead, 
                    0, "dimgrey"]);

            // bering holder
            up(nut_length) {
                tube(h=bearing_tw, id=bearing_od+gap*2, od=bearing_od+4, anchor=BOTTOM);
                tube(h=nut_length-5, id=nut_od-margin, od1=nut_od, od2=bearing_od+4, anchor=TOP);
            }

            // arm
            fork_width=3;
            groove_length=6;
            arm_height=10;
            arm_length=shaft_offset+groove_length/2;
            up(arm_height/2) difference() {
                right(arm_length) {
                    // fork
                    difference() {
                        groove_width=shaft_od+2;
                        cube([shaft_offset+4, groove_width+fork_width*2, arm_height], anchor=CENTER+RIGHT);
                        right(margin) cube([groove_length+margin, groove_width, arm_height+margin], anchor=CENTER+RIGHT);
                        left(groove_length) cylinder(h=arm_height+margin, d=groove_width, anchor=CENTER);
                    }

                    // fork rounding
                    offset=(shaft_od+fork_width)/2+1;
                    fwd(offset)  cylinder(h=arm_height, d=fork_width, anchor=CENTER);
                    back(offset) cylinder(h=arm_height, d=fork_width, anchor=CENTER);

                    // slider
                    up(arm_height/2-2) yrot(-90) {
                        offset=(shaft_od+3)/2+gap;
                        fwd(offset)  cylinder(h=arm_length, d=3);
                        back(offset) cylinder(h=arm_length, d=3);
                    }
                }

                // center bore
                cylinder(h=arm_height+margin*2, d=nut_od-margin, anchor=CENTER);
            }
        }

        // magnet insert
        up(nut_length-magnet_height-0.6) zrot(-45) right(bearing_id/2)
            cuboid([10, magnet_od+gap*2, magnet_height+gap*2], rounding=magnet_od/2+gap, edges=[LEFT], except=[TOP,BOT], anchor=BOTTOM+LEFT);
    }
}

module UpperBody(shaft_offset=18, shaft_od=3, bearing_id=10, bearing_od=18, bearing_tw=1.25) {
    margin=0.01;
    gap=0.1;
    color("dimgrey")
    difference() {
        arm_height=8;
        arm_width=10;
        cone_height=arm_height-bearing_tw;

        // body
        union() {
            // main
            tube(h=cone_height, id=bearing_id, od1=24, od2=bearing_od+4, anchor=BOTTOM);
            up(arm_height) tube(h=bearing_tw, id=bearing_od+gap*2, od=bearing_od+4, anchor=TOP);

            // arm
            difference() {
                cube([shaft_offset, arm_width, arm_height], anchor=BOTTOM+LEFT);
                down(margin) {
                    cylinder(h=cone_height+margin*2, d=bearing_id+margin*2);
                    up(cone_height) cylinder(h=bearing_tw+margin*2, d=bearing_od+4-margin*2);
                    right(shaft_offset) cylinder(arm_height+margin*2, d=shaft_od+gap);
                }
            }
            right(shaft_offset) {
                tube(h=arm_height+margin, id=shaft_od+gap, od=arm_width, anchor=BOTTOM);
                up(arm_height) tube(h=8, id=shaft_od+gap, od1=arm_width, od2=6, anchor=BOTTOM);
            }
        }

        // screw holes
        for(r=[0, 90, 180, 270]) zrot(r) fwd(screw_r) {
            down(margin) cylinder(h=arm_height+margin*2, d=screw_id);
            up(arm_height-bearing_tw+margin) cylinder(h=2.5, d=6.4, anchor=TOP, $fn=6);
        }

        // magnet inset
        up(cone_height-magnet_height-0.6) zrot(45) right(bearing_id/2)
            cuboid([10, magnet_od+gap*2, magnet_height+gap*2], rounding=magnet_od/2+gap, edges=[LEFT], except=[TOP,BOT], anchor=BOTTOM+LEFT);

    }
}
