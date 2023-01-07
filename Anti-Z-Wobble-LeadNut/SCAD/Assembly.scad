include <BOSL2/std.scad>
include <NopSCADlib/lib.scad>

use <WobbleLessLeadnut.scad>
use <ThrustBearing.scad>
use <DetentShaft.scad>

// thrust bearing and detent shaft
// 0: bearing name
// 1: diameter of innner
// 2: diameter of outer
// 3: thickness of washer
// 4: thickness of ball
// 5: shaft offset
// 6: shaft length
// 7: shaft od
F12_21M = ["F12-21M", 12, 21, 1.30, 3.00, 19, 30, 3];
F10_18  = ["F10-18",  10, 18, 1.25, 3.00, 18, 30, 3];
T51200  = ["51200",   12, 26, 3.20, 5.55, 22, 30, 3];

function bearing_id() = type[1];
function bearing_od() = type[2];
function bearing_tw() = type[3];
function bearing_tb() = type[4];
function shaft_offset() = type[5];
function shaft_length() = type[6];
function shaft_od()   = type[7];

module PreviewAssembly(type=F10_18, nut_lead=8) {
    $fs=0.01;
    $fn=60;
    margin=0.01;
    height = nut_length()
        + bearing_tw()*2+bearing_tb()
        + 8-bearing_tw()
        + margin*2;

    LowerBody(
        shaft_offset=shaft_offset(),
        shaft_od=shaft_od(),
        bearing_id=bearing_id(),
        bearing_od=bearing_od(),
        bearing_tw=bearing_tw(),
        nut_lead=nut_lead);

    up(height) vflip() 
        UpperBody(
            shaft_offset=shaft_offset(), 
            shaft_od=shaft_od(), 
            bearing_id=bearing_id(), 
            bearing_od=bearing_od(), 
            bearing_tw=bearing_tw());

    up(height) right(shaft_offset()) 
        DetentShaft(
            h=shaft_length(), 
            d=shaft_od(), 
            anchor=TOP);

    up(nut_length()+margin) 
        ThrustBering(
            id=bearing_id(), 
            od=bearing_od(), 
            tb=bearing_tb(), 
            tw=bearing_tw(), 
            reverse=true);
}

module RenderingAssembly(type=F10_18, nut_lead=8) {
    $fn=180;
    interval=bearing_od()+4;

    back(interval/2) zrot(180) left(shaft_offset()-4) 
        UpperBody(
            shaft_offset=shaft_offset(), 
            shaft_od=shaft_od(), 
            bearing_id=bearing_id(), 
            bearing_od=bearing_od(), 
            bearing_tw=bearing_tw());
    fwd(interval/2) 
        LowerBody(
            shaft_offset=shaft_offset(),
            shaft_od=shaft_od(),
            bearing_id=bearing_id(),
            bearing_od=bearing_od(),
            bearing_tw=bearing_tw(),
            nut_lead=nut_lead);
}