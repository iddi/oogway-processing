
void drawIntro() {
  pushStyle();
  textFont(font, 32);
  fill(0);
  text("No.21, Basic Type CGG", 200, 50);
  textFont(font, 16);
  text("Bring the arbitrary line AB by glide-reflection into the position BC such that it connects, "
    + "the angle ABC being arbitrary (glide-reflection axis HI parallel to AC having the same "
    + "distance from A and B). Complete the figure by a C-line CA."
    , 200, 100, 700, 200);
  text("Number of arbitrary lines: 2\nNetwork: 666\n4 Positions."
    , 650, 180, 700, 100); 
  popStyle();
}

