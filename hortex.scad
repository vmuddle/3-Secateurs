// A screw to the wall holder for a pair of Secateurs

// need to know:
// - the diameter of the screw and the length of the screw to make this part. The screw is a standard M4 screw, which has a diameter of 4mm and a length of 20mm.
// - the width of the holder
// - the thickness of the holder
// - the height of the holder
// It should be a slip fit with the sharp end down.
$fn=360;

screw_diameter = 4.5; // diameter of the screw in mm
screw_length = 70; // length of the screw in mm
screw_head_diameter = 7; // diameter of the screw head in mm
holder_width = 30; // width of the holder in mm
holder_thickness = 10; // thickness of the holder in mm
holder_height = 20; // height of the holder in mm

bladeSpace = 12;
backingSpace = 6;
bladeWidth = 62;
wallThickness=1;

totalWidth=bladeWidth + 30; // allow 15mm of space on either side of the blade for the holder

screwHoleSpacing = (totalWidth - holder_height) / 2; // distance between the centers of the screw holes

module screwHole() {
    cylinder(d=screw_diameter, h=screw_length, center=true);
}

module sidePost(newHeight=backingSpace, chamfer=false) {
    //cube([holder_height,holder_height,bladeSpace], true);
    if(chamfer) {
        cylinder(h=newHeight-1, d=holder_height);
        translate([0,0,newHeight]) {
            cylinder(h=1, d1=holder_height, d2=holder_height-2);
        }
    } else {
        cylinder(h=newHeight, d=holder_height);
    }
}

module sidePosts(newHeight, chamfer) {
    translate([screwHoleSpacing, 0, 0])
        sidePost(newHeight, chamfer);
    translate([-screwHoleSpacing, 0, 0])
        sidePost(newHeight, chamfer);

}

module screwHoles() {
    translate([screwHoleSpacing, 0, 0])
        screwHole();
    translate([-screwHoleSpacing, 0, 0])
        screwHole();
}

module frontPlate() {
    difference() {
        union() {
            hull() {
                sidePosts(wallThickness/2, true);
                mirror([0,0,1]) {
                    sidePosts(wallThickness/2, true);
                }
            }
            mirror([0,0,1])
                sidePosts(wallThickness, false);
            
        }
        screwHoles();
    }
}

module backingPlate() {
    difference() {
        union() {
            hull() {
                sidePosts(backingSpace, true);
            }
            translate([0,0,backingSpace]) {
                sidePosts(bladeSpace+1, false);
            }
        }
        screwHoles();
    }
}

backingPlate();
translate([0,50,0])
    frontPlate();
%cube([52, 1, 20], true);
translate([0,0,3.5])
%cube([42, 30, 7], true);