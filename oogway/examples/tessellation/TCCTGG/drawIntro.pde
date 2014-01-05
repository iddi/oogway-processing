
void drawIntro() {
  pushStyle();
  textFont(font, 32);
  fill(0);
  text("No.23, Basic Type TCTGG", 200, 50);
  textFont(font, 16);
  text("Shift the arbitrary line AB to DC. "
    + "Connect A to D by means of a C-line AD. "
    + "by an arbitrary line and glide-reflect AE towards ED. "
    + "Then draw from B towards a point E on the perpendicular bisector NE of BC an arbitrary line BE "
    + "and glide-reflect it into the position EC, making sure that it connects "
    + "(glide-reflection axis HI parallel to BC in the same distance from B as from E.)"
    , 200, 100, 700, 200);
  text("Number of arbitrary lines: 3\nNetwork: 44333\n4 Positions."
    , 650, 220, 700, 100); 
  popStyle();
}

