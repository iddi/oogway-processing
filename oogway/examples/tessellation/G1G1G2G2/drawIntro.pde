
void drawIntro() {
  pushStyle();
  textFont(font, 32);
  fill(0);
  text("No.17, Basic Type G1G1G2G2", 200, 50);
  textFont(font, 16);
  text("Move the arbitrary line AB by glide-reflection so that it connects to BC "
    + "(glide-reflect axis H1I1 parallel to AC at the same distance from B as from A). "
    + "Draw one more arbitrary line CD, D being anywhere on the perpendicular bisector MD of AC. "
    + "Glide-reflect CD into the position DA so that it connects "
    + "(glide-reflection axis H2I2 parallel to H1I1 going through the midpoint K of DM)."
    , 200, 100, 700, 200);
  text("Number of arbitrary lines: 2\nNetwork: 4444\n2 Positions."
    , 650, 230, 700, 100); 
  popStyle();
}

