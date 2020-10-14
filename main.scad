$fa = 1;
$fs = 0.4;
$fn = 100;

screw_diameter = 5.00;
screw_cap_diameter = 7.00;
screw_thickness = 4.00;

angle = 10.00;
arm_width = 20.00;
arm_thickness = 8.00;
arm_fastening_length = 100.00;

raw_speaker_height = 180.00;
speaker_depth = 120.00;

extra_height = sin(angle) * speaker_depth;
speaker_height = raw_speaker_height + extra_height;

front_overlap_height=20.00;

module clamp()
{
    cube([speaker_depth+arm_thickness*2, arm_width, arm_thickness]);
    translate([speaker_depth+arm_thickness, 0, 0]) cube([arm_thickness, arm_width, speaker_height]);
    translate([0, 0, 0]) cube([arm_thickness, arm_width, front_overlap_height+arm_thickness]);
}

hh = cos(angle) * speaker_height;
vv = sin(angle) * speaker_height;

rotate ([0, angle , 0]) translate([-(speaker_depth+2*arm_thickness), 0, 0]) clamp();

/* Actual fastening */
difference() {
    translate([vv-arm_fastening_length, 0, hh]) cube([arm_fastening_length, arm_width, arm_thickness]);

    offset_1 = arm_fastening_length / 4.00;
    translate([vv-arm_fastening_length + offset_1, arm_width/2.00, hh-1.00]) cylinder(h=arm_thickness+2.00, d=screw_diameter);
    translate([vv-arm_fastening_length + offset_1, arm_width/2.00, hh-4.00]) cylinder(h=arm_thickness, d=screw_cap_diameter);

    offset_2 = 2*(arm_fastening_length / 3.00);
    translate([vv-arm_fastening_length + offset_2, arm_width/2.00, hh-1.00]) cylinder(h=arm_thickness+2.00, d=screw_diameter);
    translate([vv-arm_fastening_length + offset_2, arm_width/2.00, hh-4.00]) cylinder(h=arm_thickness, d=screw_cap_diameter);
}
