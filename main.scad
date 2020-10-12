$fa = 1;
$fs = 0.4;
$fn = 100;

angle = 20.00;
arm_width = 20.00;
arm_thickness = 8.00;

speaker_height = 180.00;
speaker_depth = 120.00;

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
translate([vv, 0, hh]) cube(10, 10, 1);
