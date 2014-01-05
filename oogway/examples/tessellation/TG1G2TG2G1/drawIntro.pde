
void drawIntro() {
  pushStyle();
  textFont(font, 32);
  fill(0);
  text("No.20, Basic Type TG1G2TG2G1", 200, 50);
  textFont(font, 16);
  text("Shift the arbitrary line AB to DC, "
    + "glide-reflect another arbitrary line AF (F arbitrary) into EB. "
    + "Glide-reflect a third arbitrary line FD into CE. "
    + "(glide-reflection axes H1I1, H2I2 perpendicular to AD at equal "
    + "distances from B and F, and from D and E, respectively.)"
    , 200, 100, 700, 200);
  text("Number of arbitrary lines: 3\nNetwork: 333333\n2 Positions."
    , 650, 200, 700, 100); 
  popStyle();
}

