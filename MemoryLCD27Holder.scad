topClipHeight = 1.4;
topClipWidth = 2;
topClipDepth = 0.4;
topClipTopOffset = 6;
topClipBottomOffset = 8;

realDisplayWidth = 62.8;
realDisplayHeight = 42.82;
realDisplayDepth = 1.64;

displayToleranceWidth = 0.2;
displayToleranceHeight = 0.2;
displayToleranceDepth = 0.2;

printerTolerance = 1.2;

displayWidth = 62.84 + displayToleranceWidth + printerTolerance;
displayHeight = 42.86 + displayToleranceHeight + printerTolerance;
displayDepth = 1.66 + displayToleranceDepth + printerTolerance;

virtualDisplayDepth = displayDepth + topClipDepth;

margin = 2;
baseplateWidth = 1.1;

fpcWidth = 9;

mountingHoleDiameter = 3;
mountingHoleOffset = 1;
mountingHoleDepth = 1;

cOffset = 0;

module clips () {
	translate([-(((displayWidth+margin)/2) - (topClipHeight/2)),(((displayHeight+margin)/2)-(topClipWidth)/2)-topClipTopOffset,0])
	cube([topClipHeight, topClipWidth, topClipDepth], center=true);

	translate([(((displayWidth+margin)/2) - (topClipHeight/2)),(((displayHeight+margin)/2)-(topClipWidth)/2)-topClipTopOffset,0])
	cube([topClipHeight, topClipWidth, topClipDepth], center=true);

	translate([-(((displayWidth+margin)/2) - (topClipHeight/2)),-(((displayHeight+margin)/2)-(topClipWidth)/2)+topClipBottomOffset,0])
	cube([topClipHeight, topClipWidth, topClipDepth], center=true);


	translate([(((displayWidth+margin)/2) - (topClipHeight/2)),-(((displayHeight+margin)/2)-(topClipWidth)/2)+topClipBottomOffset,0])
	cube([topClipHeight, topClipWidth, topClipDepth], center=true);
}

module displayHolder () {
   difference() {
  		cube([displayWidth+margin, displayHeight+margin, virtualDisplayDepth], center=true);

		cube([displayWidth,displayHeight,virtualDisplayDepth+2], center= true);
	}

	translate([0,0,virtualDisplayDepth/2 - topClipDepth / 2])
	clips();

	translate([0,0,-baseplateWidth])
	cube([displayWidth+margin, displayHeight+margin, baseplateWidth], center=true);
}

module holder (cOffset) {

	difference() {
		cube([(mountingHoleDiameter*2)+mountingHoleOffset,mountingHoleDiameter*2,mountingHoleDepth], center=true);
		
		translate([cOffset,0,0])
		color("red") {
			cylinder(h=mountingHoleDepth+2, r=mountingHoleDiameter/2, center=true, $fs=.1);
		}
	}
}

module main () {
difference() {
	displayHolder();

	translate([0,-(((displayHeight+margin)/2)-(topClipWidth)/2),])
	cube([fpcWidth, 2,virtualDisplayDepth+.2], center=true);
}


translate([-(((displayWidth+margin)/2) - (topClipHeight/2)) - 3,(((displayHeight+margin)/2)-(topClipWidth)/2)-topClipTopOffset,-(virtualDisplayDepth/2 - mountingHoleDepth/ 2)])
holder(-0.5);

translate([-(((displayWidth+margin)/2) - (topClipHeight/2)) - 3,-(((displayHeight+margin)/2)-(topClipWidth)/2)+topClipBottomOffset,-(virtualDisplayDepth/2 - mountingHoleDepth/ 2)])
holder(-0.5);

cOffset = -0.5;
translate([(((displayWidth+margin)/2) - (topClipHeight/2)) + 3,(((displayHeight+margin)/2)-(topClipWidth)/2)-topClipTopOffset,-(virtualDisplayDepth/2 - mountingHoleDepth/ 2)])
holder(0.5);

translate([(((displayWidth+margin)/2) - (topClipHeight/2)) + 3,-(((displayHeight+margin)/2)-(topClipWidth)/2)+topClipBottomOffset,-(virtualDisplayDepth/2 - mountingHoleDepth/ 2)])
holder(0.5);

}
//main();
projection(cut=false) main();