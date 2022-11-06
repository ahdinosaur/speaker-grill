include <./hexagon.scad>;
include <./hex-grid.scad>;

// circle
//   inner diameter 159mm
//   outer diameter 192mm
//   (implied width 16.5)
//   width 16.8mm
//
//
// circle
//   bolt is 87.3mm from center
//   bolts are 138.2mm apart
//
//
//  calculate angle:
//    - opposite = 138.2 / 2 = 69.1
//    - hypotenuse = 87.3
//    - sin(angle) = opposite / hypotenuse
//    - angle = 52.33

EPS = 0.001;

SPEAKER_GRILL_BIG_DIAMETER = 174.6;
SPEAKER_GRILL_BIG_CORNER_ANGLE = 52.33;

SPEAKER_GRILL_THICKNESS = 2;
SPEAKER_GRILL_BORDER_WIDTH = 16;

SPEAKER_GRILL_MAGNET_RADIUS = 5;
SPEAKER_GRILL_MAGNET_MARGIN_RADIUS = 15;
SPEAKER_GRILL_MAGNET_HEIGHT = 2 + EPS;

module speaker_grill() {
  difference() {
    linear_extrude(height = SPEAKER_GRILL_THICKNESS)
    speaker_grill_big_profile();

    translate([0,0, SPEAKER_GRILL_THICKNESS - SPEAKER_GRILL_MAGNET_HEIGHT])
    linear_extrude(height = SPEAKER_GRILL_MAGNET_HEIGHT + EPS)
    speaker_grill_corner_holes_profile();
  }
}

module speaker_grill_frame() {
  union() {
    speaker_grill_big_profile();
  }
}

module speaker_grill_corner_holes_profile() {
  union() {
    speaker_grill_big_corner_hole_profiles();
  }
}

module speaker_grill_big_profile() {
  union() {
    difference() {
      circle(
        r = SPEAKER_GRILL_BIG_DIAMETER + SPEAKER_GRILL_BORDER_WIDTH
      );

      circle(
        r = SPEAKER_GRILL_BIG_DIAMETER
      );
    }

    speaker_grill_big_corner_margin_profiles();
  }
}

module speaker_grill_big_corner_margin_profiles() {
  speaker_grill_big_corners()
  circle(r = SPEAKER_GRILL_MAGNET_MARGIN_RADIUS);
}

module speaker_grill_big_corner_hole_profiles() {
  speaker_grill_big_corners()
  circle(r = SPEAKER_GRILL_MAGNET_RADIUS);
}

module speaker_grill_big_corners() {
  translate([0, SPEAKER_GRILL_BIG_DIAMETER])
  children();

  rotate(SPEAKER_GRILL_BIG_CORNER_ANGLE)
  translate([0, SPEAKER_GRILL_BIG_DIAMETER])
  children();

  rotate(-SPEAKER_GRILL_BIG_CORNER_ANGLE)
  translate([0, SPEAKER_GRILL_BIG_DIAMETER])
  children();

  rotate(-180)
  translate([0, SPEAKER_GRILL_BIG_DIAMETER])
  children();

  rotate(-180 - SPEAKER_GRILL_BIG_CORNER_ANGLE)
  translate([0, SPEAKER_GRILL_BIG_DIAMETER])
  children();

  rotate(-180 + SPEAKER_GRILL_BIG_CORNER_ANGLE)
  translate([0, SPEAKER_GRILL_BIG_DIAMETER])
  children();
}

speaker_grill();

// speaker_bolt();
