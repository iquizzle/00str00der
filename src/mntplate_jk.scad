// 00str00der-jkmnt is a mounting plate to attach an 00str00der base
// to Jonas Kuehling's x-carriage (link)
// authors:  f. beachler
// license:  Creative Commons Commercial 3.0 share-alike w/attribution

use <MCAD/nuts_and_bolts.scad>
//use <00str00der.scad>
//use <../[path_to_xcarriage]/jonaskueling_x-carriage/jonaskuehling_x-carriage_lm8uu.scad>

plate_thickness = 4 + 3;
plate_width = 95;
plate_leadout = 65;
%translate([0, 0, 0]) simonkuehling_x_carriage();
%translate([15, -8, -1 * (plate_thickness + 32.2)]) rotate([0, 180, 90]) 00str00der();
mntplate_jk(plate_thickness, plate_width, plate_leadout, 4 + 0.7);

module mntplate_jk(t, w, l, m4d) {
	difference() {
		// base
		union() {
			difference() {
				minkowski() {
					difference() {
						translate([22, 0, -t / 2]) cube([w - 5, l - 5, t], center = true);
						// remove some material
						translate([50, -28, -t / 2]) cube([w / 2, l / 4, t + 0.02], center = true);
						translate([50, 28, -t / 2]) cube([w / 2, l / 4, t + 0.02], center = true);
					}
					cylinder(r=5 / 2, h = 0.01, center=true);
				}
				// hotend cavity
				cylinder(r=40 / 2 + 1, h = 12.5 + t, center=true);
			}
			translate([20, 0, -t / 2]) cube([10, l, t], center = true);
		}
		// carriage mnt holes
		mntholes_jk(t, m4d);
		// extruder mnt holes
		translate([15, -8, -t - 10]) rotate([0, 180, 90]) mntholes_00str00der(t, m4d);
	}
}

module mntholes_00str00der(t, m4d) {
		for (x = [1, -13]) {
			translate([x, -4.5, -t * 2 - 0.01]) rotate([0,180,0]) cylinder(r = 2.2, h = t + 5,center=true);
			// countersink holes
			translate([x, -4.5, -t * 2 - 0.01 - 2]) rotate([0,180,0]) cylinder(r = 3.9, h = t,center=true);
		}
		for (x = [-8]) {
			translate([x, -43, -t * 2 - 0.01]) rotate([0,180,0]) cylinder(r = 2.2, h = t + 5,center=true);
			// countersink holes
			translate([x, -43, -t * 2 - 0.01 - 2]) rotate([0,180,0]) cylinder(r = 3.9, h = t,center=true);
		}
}

module mntholes_jk(t, m4d) {
		for (i = [0 : 1]) {
			rotate(180*i)
				for (hole = [-1 : 1]) {
					rotate(hole*22)
						translate([0, 25, -t - 0.01])
							cylinder(r = m4d / 2, h = t + 0.1, $fn = 15);
				}
		}
}