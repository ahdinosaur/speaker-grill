// https://gist.github.com/lorennorman/1534990

include <hexagon.scad>;

module shell(radius) {
  difference() {
    hexagon(radius * 1.2); // base
    hexagon(radius * 1.1); // hole
  }
}

module piece(radius) {
  translate([0, 0, -radius / 12])
  scale([1, 1, 0.5])
  hexagon(radius);
}

module shell_with_piece(radius) {
  shell(radius);
  piece(radius);
}

function column_to_offset(column, offset) = (column % 2) * offset;

module translate_to_hex(x_coord, y_coord, hex_width) {
  translate([
    x_coord*hex_width * 1.75,
    y_coord*hex_width * 2 + column_to_offset(x_coord, hex_width),
    0
  ])
  children();
}

module hex_grid(rows, columns, hex_width) {
  for(x = [0:columns-1]) {
    for(y = [0:rows-1]) {
      translate_to_hex(x, y, hex_width)
      shell(hex_width);
    }
  }
}
