
void drawIntro(){
  pushStyle();
     textFont(font,32);
     fill(0);
     text("No.12, Basic Type C3C3C6C6",200,50);
     textFont(font,16);
     text("Turn the arbitrary line AB around A by 120 degrees into the position AC. "
    + "Let D together with C and B form an equilateral triangle, which does not contain A. "
    + "Draw the arbitrary line BD and turn it around D over 60 degrees into the position DC. "
         , 200, 100,700,200);
     text("Number of arbitrary lines: 2\nNetwork: 6434\n6 Positions."
         , 650, 180, 700, 100); 
  popStyle();
}


