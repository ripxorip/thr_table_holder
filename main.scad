$fa = 1;
$fs = 0.4;
$fn = 100;

screw_diameter = 4.20;
screw_cap_diameter = 8.20;
screw_thickness = 4.20;

angle = 10.00;
arm_width = 20.00;
arm_thickness = 10.00;
arm_fastening_length = 100.00;

raw_speaker_height = 183.50;
speaker_depth = 145.00;

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

    offset_1 = arm_fastening_length / 5.00;
    translate([vv-arm_fastening_length + offset_1, arm_width/2.00, hh-1.00]) cylinder(h=arm_thickness+2.00, d=screw_diameter);
    translate([vv-arm_fastening_length + offset_1, arm_width/2.00, hh-5.00]) cylinder(h=arm_thickness, d=screw_cap_diameter);

    offset_2 = 1.8*(arm_fastening_length / 3.00);
    translate([vv-arm_fastening_length + offset_2, arm_width/2.00, hh-1.00]) cylinder(h=arm_thickness+2.00, d=screw_diameter);
    translate([vv-arm_fastening_length + offset_2, arm_width/2.00, hh-5.00]) cylinder(h=arm_thickness, d=screw_cap_diameter);
}

/* Inner Enforcement */
enf_hyp = arm_thickness / sin(angle);
enf_len = cos(angle) * enf_hyp;
translate([vv-arm_thickness-arm_thickness, 0, hh-enf_len]) cube([arm_thickness, arm_width, enf_len]);

/* Outer Enforcement */
translate([0, arm_width, 0])
    rotate([90, 0, 0])
        linear_extrude(height=arm_width)
            polygon([[0,0], [vv/2,0], [vv,hh]]);


/* Lower Enforcement */
/*
lower_enf_len = arm_thickness*3;
translate([0, arm_width, 0])
    rotate([90, 0, 0])
        linear_extrude(height=arm_width)
            polygon([[-lower_enf_len,0], [0,0], [-lower_enf_len, 10]]);
*/
