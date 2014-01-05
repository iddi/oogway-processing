
void drawIntro() {
  pushStyle();
  textFont(font, 32);
  fill(0);
  text("No.25, Basic Type CGCG", 200, 50);
  textFont(font, 16);
  text("Glide-reflect the arbitrary line AB into the position DC "
    + "(glide-reflection axis HI has the same distance from A and C, "
    + "another equal distance from B and D). "
    + " Connect A to D by a C-line, "
    + " and also connect B to C by yet another C-line."
    , 200, 100, 700, 200);
  text("Number of arbitrary lines: 3\nNetwork: 4444\n4 Positions."
    , 650, 180, 700, 100); 
  popStyle();
}

