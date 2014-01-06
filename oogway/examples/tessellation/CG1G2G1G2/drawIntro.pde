
void drawIntro() {
  pushStyle();
  textFont(font, 32);
  fill(0);
  text("No.27, Basic Type CG1G2G1G2", 200, 50);
  textFont(font, 16);
  text("Glide-reflect the arbitrary line AB to CD "
    + "(glide-reection axes H1I1 at a distance a from A and C, and at a distance b from B and D). "
    + " Draw the arbitrary line BC and glide-reflect along the glide-reflection axis H2I2 towards AE "
    + "(H2I2 _|_ H1I1 equidistant from A and C)."
    + " Complete the figure by a C-line DE.  "
    , 200, 100, 700, 200);
  text("Number of arbitrary lines: 3\nNetwork: 43433\n4 Positions."
    , 650, 200, 700, 100); 
  popStyle();
}

