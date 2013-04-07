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

module large_pulley_w_hob(){
difference(){
union(){
color("DarkGreen",1) translate([0,0,6]) cylinder(r=37.7/2,h=11.2);
color("DarkGreen",1) translate([0,0,6]) cylinder(r=43.25/2,h=1);
color("DarkGreen",1) translate([0,0,17.2]) cylinder(r=43.25/2,h=1);
color("DarkGreen",1) translate([0,0,0]) cylinder(r=17.5/2,h=6.5);}
cylinder(r=4,h=50,center=true);}
color("Gray",1) translate([0,0,18]) rotate([0,180,0]) boltHole(8,length=60,tolerance=0.5);
}

module hotend_w_screws(){
union(){
translate([0,0,-35]) cylinder(r=5/16*25.4+0.25,h=35);
translate([0,6+3/2-0.25,-4.76-3/2-0.75]) rotate([0,-90,0]) cylinder(r=3/2+0.05,h=50,center=true);
translate([0,-6-3/2+0.25,-4.76-3/2-0.75]) rotate([0,-90,0]) cylinder(r=3/2+0.05,h=50,center=true);
}
}

module fillet(rad,height){
translate([-rad,-rad,0])
difference(){
translate([0,0,-height/2]) cube([rad+0.01,rad+0.01,height]);
cylinder(h=height+1,r=rad,center=true);
}}

module stepper_w_pulley(){
stepper_motor_mount(17);
translate([0,0,5])
union(){
color("DarkGreen",1) translate([0,0,6]) cylinder(r=22.5/2,h=11.2);
color("DarkGreen",1) translate([0,0,6]) cylinder(r=27.5/2,h=1);
color("DarkGreen",1) translate([0,0,17.2]) cylinder(r=27.5/2,h=1);
color("DarkGreen",1) translate([0,0,0]) cylinder(r=17.5/2,h=6.5);}}

module stepper_w_pulley2(){
translate([0,0,-13-6]) cube(42.3,center=true);
translate([0,0,5])
union(){
color("DarkGreen",1) translate([0,0,6]) cylinder(r=28.5/2,h=50,center=true);
color("DarkGreen",1) translate([31/2,31/2,0]) cylinder(r=3/2+0.05,h=50,center=true);
color("DarkGreen",1) translate([-31/2,31/2,0]) cylinder(r=3/2+0.05,h=50,center=true);
color("DarkGreen",1) translate([31/2,-31/2,0]) cylinder(r=3/2+0.05,h=50,center=true);
color("DarkGreen",1) translate([-31/2,-31/2,0]) cylinder(r=3/2+0.05,h=50,center=true);
}}

module 608_bearing(tolerance=0.1,center_ring=1){
difference(){
union(){
color("FireBrick",1) cylinder(r=22/2+tolerance,h=7,center=true);

if (center_ring == 1){
color("FireBrick",1) cylinder(r=13.5/2,h=9,center=true);}

}

cylinder(r=8/2,h=9+0.1,center=true);}
}