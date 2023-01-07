include <Assembly.scad>

type=F12_21M;
nut_lead=8;

if ($preview) {
    PreviewAssembly(type, nut_lead);
} else {
    RenderingAssembly(type, nut_lead);
}
