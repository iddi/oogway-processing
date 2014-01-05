
void drawIntro() {
  pushStyle();
  textFont(font, 32);
  fill(0);
  text("No.24, Basic Type TCCTGG", 200, 50);
  textFont(font, 16);
  text("Shift the arbitrary line AB to DC. "
    + "Connect A as well as D to the arbitrary point F by one C-line each. "
    + "Choose E on the perpendicular bisector NE of BC, "
    + "and move the arbitrary line BE by glide-reflection towards EC, "
    + "making sure that it connects (glide-reflection axis HI.) "
    , 200, 100, 700, 200);
  text("Number of arbitrary lines: 4\nNetwork: 333333\n4 Positions."
    , 650, 220, 700, 100); 
  popStyle();
}

