
void drawIntro(){
  pushStyle();
     textFont(font,32);
     fill(0);
     text("No.8, Basic Type C3C3C3C3",200,50);
     textFont(font,16);
     text("Turn the arbitrary line AB around A over 120 degrees into the position AC."
    + " Let D be the refection-point of A with respect to the line through B and C."
    + " Connect D to B by an arbitrary line and turn it around D by 120 degrees into the position DC."
         , 200, 100,700,200);
     text("Number of arbitrary lines: 2\nNetwork: 6363,\n3 Positions."
         , 650, 180,700,100); 
  popStyle();
}

