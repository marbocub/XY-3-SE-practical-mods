include <BOSL2/std.scad>

module ThrustBering(id=10, od=18, tw=1.25, tb=3, reverse=false) {

    // washers (reverse side)
    color("silver") difference() {
        for (h=[0, tw+tb]) up(h)
            tube(h=tw, od=od, id=id, anchor=BOTTOM);

        if (reverse) {
            up(2*tw+tb-0.3) torus(d_maj=(id+od)/2, d_min=tb, anchor=BOTTOM);
            up(0+0.3)       torus(d_maj=(id+od)/2, d_min=tb, anchor=TOP);
        } else {
            up(tw+tb+0.3)   torus(d_maj=(id+od)/2, d_min=tb, anchor=TOP);
            up(tw-0.3)      torus(d_maj=(id+od)/2, d_min=tb, anchor=BOTTOM);
        }
    }

    // balls
    d=(id+od)/2;
    n=round((d * PI) / (tb*4)) *2 +1;   // odd number
    color("silver") up(tw)
        for (p=circle(d=d, $fn=n)) move(p)
            sphere(d=tb, anchor=BOTTOM);

    // sleve
    color("gold") up(tw + tb/2) 
        tube(h=tb/2, id=id+1, od=od-1);

}

