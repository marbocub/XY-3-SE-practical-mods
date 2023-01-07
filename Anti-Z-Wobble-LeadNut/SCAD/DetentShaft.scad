include <BOSL2/std.scad>

module DetentShaft(h=30, d=3, anchor=TOP) {
    color("gold")
        cylinder(h=h, d=d, anchor=anchor);
}
