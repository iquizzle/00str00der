use <MCAD/nuts_and_bolts.scad>

module fillet(rad,height){

difference(){
translate([0,0,-height/2]) cube([rad-0.05,rad-0.05,height]);
cylinder(h=height+1,r=rad,center=true);
}}

module nutSlot(slot,tolerance,size=4){
union(){
for (i=[0:0.5:slot]){
translate([i,0,0]) nutHole(size,tolerance=tolerance);}}}
