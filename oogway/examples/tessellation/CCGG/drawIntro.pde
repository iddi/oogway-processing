
void drawIntro() {
  pushStyle();
  textFont(font, 32);
  fill(0);
  text("No.22, Basic Type CCGG", 200, 50);
  textFont(font, 16);
  text("Move the arbitrary line AB by glide-reflection to the position BC so that it connects "
    + "(glide-reflection axis HI parallel to AC at the same distance from A as from B). "
    + "Draw both C-lines AD and CD towards an arbitrary point D."
    , 200, 100, 700, 200);
  text("Number of arbitrary lines: 3\nNetwork: 4444\n4 Positions."
    , 650, 180, 700, 100); 
  popStyle();
}

