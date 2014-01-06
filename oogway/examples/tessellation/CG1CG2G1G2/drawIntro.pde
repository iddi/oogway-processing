
void drawIntro() {
  pushStyle();
  textFont(font, 32);
  fill(0);
  text("No.28, Basic Type CG1CG2G1G2", 200, 50);
  textFont(font, 16);
  text("Glide-reflect the arbitrary line AB to CD (glide-reection axis H1I1). "
  +"Draw the arbitrary line BC and glide-reflect it in the glide-reection axis H2I2 "
  + "which is perpendicular to H1I1, towards FE (E arbitrary.) "
  + "Connect D to F by a C-line and connect A to E in the same way."
    , 200, 100, 700, 200);
  text("Number of arbitrary lines: 4\nNetwork: 333333\n4 Positions."
    , 650, 200, 700, 100); 
  popStyle();
}


