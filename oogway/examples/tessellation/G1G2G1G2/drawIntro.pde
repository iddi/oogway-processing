
void drawIntro() {
  pushStyle();
  textFont(font, 32);
  fill(0);
  text("No.26, Basic Type G1G2G1G2", 200, 50);
  textFont(font, 16);
  text("Let A, B, C and D be the points of a rectangle. "
    + "Glide-reflect the arbitrary line AB to CD. "
    + "Glide-reflect another arbitrary line AD towards CB "
    + "(glide-reflection axes perpendicular to the sides of the rectangle "
    +" and going through the center-point of the rectangle) "
    , 200, 100, 700, 200);
  text("Number of arbitrary lines: 2\nNetwork: 4444\n4 Positions."
    , 650, 200, 700, 100); 
  popStyle();
}

