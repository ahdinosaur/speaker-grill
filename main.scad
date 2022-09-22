include <./hex-grid.scad>;

SPEAKER_GRILL_LENGTH = 200;
SPEAKER_GRILL_WIDTH = 80;
SPEAKER_GRILL_THICKNESS = 10;
SPEAKER_GRILL_BORDER_WIDTH = 5;
SPEAKER_GRILL_HEX_WIDTH = 4;

module speaker_grill() {
  linear_extrude(SPEAKER_GRILL_THICKNESS);
  speaker_grill_profile();
}

module speaker_grill_profile() {
  union() {
    speaker_grill_hex_grid_profile();

    speaker_grill_border_profile();
  }
}

module speaker_grill_hex_grid_profile() {
  hex_grid_rows = (SPEAKER_GRILL_WIDTH - 2 * SPEAKER_GRILL_BORDER_WIDTH) / SPEAKER_GRILL_HEX_WIDTH;
  hex_grid_cols = (SPEAKER_GRILL_LENGTH - 2 * SPEAKER_GRILL_BORDER_WIDTH) / SPEAKER_GRILL_HEX_WIDTH;

  translate([
    SPEAKER_GRILL_BORDER_WIDTH,
    SPEAKER_GRILL_BORDER_WIDTH,
  ])
  intersection() {
    square([
      SPEAKER_GRILL_LENGTH - SPEAKER_GRILL_BORDER_WIDTH,
      SPEAKER_GRILL_WIDTH - SPEAKER_GRILL_BORDER_WIDTH,
    ]);

    hex_grid(hex_grid_rows, hex_grid_cols, SPEAKER_GRILL_HEX_WIDTH);
    }
}

module speaker_grill_border_profile() {
  translate([
    (1/2) * SPEAKER_GRILL_LENGTH,
    (1/2) * SPEAKER_GRILL_WIDTH,
  ])
  difference() {
    square([
      SPEAKER_GRILL_LENGTH,
      SPEAKER_GRILL_WIDTH,
    ], center = true);

    square([
      SPEAKER_GRILL_LENGTH - 2 * SPEAKER_GRILL_BORDER_WIDTH,
      SPEAKER_GRILL_WIDTH - 2 * SPEAKER_GRILL_BORDER_WIDTH,
    ], center = true);
  }
}

if($preview) {
  speaker_grill();
}
