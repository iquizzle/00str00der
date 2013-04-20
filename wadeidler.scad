// authors:  thigiverse (link), l. miller, f. beachler
// see (link) for GPL license

// TODO move to a config SCAD, see other TODOs
variant=0; //0 for metric
//variant=1; //1 for SAE
if(variant==0){
echo("variant: metric");
}else if(variant==1){
echo("variant: sae");
} else{
echo("WARNING: INVALID CONFIGURATION");
}

vars=[
//[m8_dia, m8_nut, m4_dia, m4_nut, m3_dia, m3_nut, bush_dia, mot_shaft, bush_rod, bush_outerdia, bush_length]
[9,16.4,5,9,4.4,7,11,5.3,8,16,11],//metric
[9,15.7,5.5,10.6,5.5,10.6,11.5,5.3,7.9375,16,11]//SAE
];

//DO NOT TOUCH THIS SECTION!
m8_diameter = vars[variant][0];
m8_nut_diameter = vars[variant][1];
m4_diameter = vars[variant][2];
m4_nut_diameter = vars[variant][3];
m3_diameter = vars[variant][4];
m3_nut_diameter = vars[variant][5];
bushing_diameter = vars[variant][6];
motor_shaft=vars[variant][7];
bushing_rodsize = vars[variant][8];
bushing_outerDiameter = vars[variant][9];
bushing_lenght = vars[variant][10];

base_thickness=7;
base_length=70;
base_leadout=25;

nema17_hole_spacing=1.2*25.4; 
nema17_width=1.7*25.4;
nema17_support_d=nema17_width-nema17_hole_spacing;

screw_head_recess_diameter=7.2;
screw_head_recess_depth=3;

motor_mount_rotation=25;
motor_mount_translation=[50.5,34,0];
motor_mount_thickness=12;

m8_clearance_hole=8.8;
hole_for_608=22.6;
608_diameter=22;
echo(608_diameter);

layer_thickness=0.4;
filament_feed_hole_d=4;
filament_diameter=3;
filament_feed_hole_offset=filament_diameter+0.5;
idler_nut_trap_depth=7.5;
idler_nut_thickness=3;

wade_block_height=55;
wade_block_width=24;
wade_block_depth=28;

gear_separation=7.4444+32.0111+0.25;

filament_pinch=[
	motor_mount_translation[0]-gear_separation-filament_feed_hole_offset-filament_diameter/2,
	motor_mount_translation[1],
	wade_block_depth/2];
idler_axis=filament_pinch-[608_diameter/2,0,0];
idler_fulcrum_offset=608_diameter/2+3.5+m3_diameter/2;
idler_fulcrum=idler_axis-[0,idler_fulcrum_offset,0];
idler_corners_radius=4; 
idler_height=12;
idler_608_diameter=608_diameter+2;
idler_608_height=9;
idler_mounting_hole_across=8;
idler_mounting_hole_up=15;
idler_short_side=wade_block_depth-2;
idler_hinge_r=m3_diameter/2+3.5;
idler_hinge_width=6.5;
idler_end_length=(idler_height-2)+5;
idler_mounting_hole_diameter=m3_diameter+0.25;
idler_mounting_hole_elongation=1;
idler_long_top=idler_mounting_hole_up+idler_mounting_hole_diameter/2+idler_mounting_hole_elongation+2.5;
idler_long_bottom=idler_fulcrum_offset;
idler_long_side=idler_long_top+idler_long_bottom;

rotate([0, -90, 0]) wadeidler();

// TODO parametrize
module wadeidler() {
	difference() {
		union() {
			//The idler block.
			translate(idler_axis+[-idler_height/2+2,+idler_long_side/2-idler_long_bottom,0])
			cube([idler_height,idler_long_side,idler_short_side],center=true);

			// The fulcrum Hinge
			translate(idler_fulcrum)
			rotate([0,0,-30]) {
				cylinder(h=idler_short_side,r=idler_hinge_r,center=true,$fn=60);
				translate([-idler_end_length/2,0,0])
					cube([idler_end_length,idler_hinge_r*2,idler_short_side],center=true);
			}		
		}

		//Back of idler.
		translate(idler_axis+[-idler_height/2+2-idler_height, idler_long_side/2-idler_long_bottom-10,0])
			cube([idler_height,idler_long_side,idler_short_side],center=true);

		//Slot for idler fulcrum mount.
		translate(idler_fulcrum)
		{
			cylinder(h=idler_short_side-2*idler_hinge_width,
				r=idler_hinge_r+0.5,center=true,$fn=60);
			rotate(-30)
				translate([0,-idler_hinge_r-0.5,0])
					cube([idler_hinge_r*2+1,idler_hinge_r*2+1, idler_short_side-2*idler_hinge_width],center=true);
		}

		//Bearing cutout.
		translate(idler_axis) {
			difference() {
				cylinder(h=idler_608_height,r=idler_608_diameter/2,
					center=true,$fn=60);
				for (i=[0,1])
					rotate([180*i,0,0])
						translate([0,0,6.9/2])
							cylinder(r1=12/2,r2=16/2,h=2);
			}
			cylinder(h=idler_short_side-6,r=m8_diameter/2-0.25/*Tight*/,
				center=true,$fn=20);
		}

		//Fulcrum hole.
		translate(idler_fulcrum)
			rotate(360/12)
				cylinder(h=idler_short_side+2,r=m3_diameter/2-0.1,center=true,$fn=8);
		//Nut trap for fulcrum screw.
		translate(idler_fulcrum+[0,0,idler_short_side/2-idler_hinge_width-1])
			rotate(360/16)
				cylinder(h=3,r=m3_nut_diameter/2,$fn=6);

		for(idler_screw_hole=[-1,1])
			translate(idler_axis+[2-idler_height,0,0]) {
				//Screw Holes.
				translate([-1,idler_mounting_hole_up, idler_screw_hole*idler_mounting_hole_across])
				rotate([0,90,0]) {
					cylinder(r=idler_mounting_hole_diameter/2,h=idler_height+2,$fn=16);
					translate([0,idler_mounting_hole_elongation,0])
						cylinder(r=idler_mounting_hole_diameter/2,h=idler_height+2,$fn=16);
					translate([-idler_mounting_hole_diameter/2,0,0])
						cube([idler_mounting_hole_diameter,idler_mounting_hole_elongation, idler_height+2]);
				}

			// Rounded corners.
			render()
				translate([idler_height/2,idler_long_top, idler_screw_hole*(idler_short_side/2)])
					difference() {
						translate([0,-idler_corners_radius/2+0.5,-idler_screw_hole*(idler_corners_radius/2-0.5)])
						cube([idler_height+2,idler_corners_radius+1,idler_corners_radius+1], center=true);
						rotate([0,90,0])
							translate([idler_screw_hole*idler_corners_radius,-idler_corners_radius,0])
								cylinder(h=idler_height+4,r=idler_corners_radius,center=true,$fn=40);
					}
			}
	}
}