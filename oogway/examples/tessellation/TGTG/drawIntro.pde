
void drawIntro() {
  pushStyle();
  textFont(font, 32);
  fill(0);
  text("No.19, Basic Type TGTG", 200, 50);
  textFont(font, 16);
  text("Shift the arbitrary line AB to DC. "
    + "Then draw the arbitrary line AD and glide-reflect it into CB "
    + "(glide-reflection axis HI perpendicular to AD at the same distance from A as from C.)"
    , 200, 100, 700, 200);
  text("Number of arbitrary lines: 2\nNetwork: 4444\n2 Positions."
    , 650, 180, 700, 100); 
  popStyle();
}

