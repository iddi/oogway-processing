
void drawIntro(){
  pushStyle();
     textFont(font,32);
     fill(0);
     text("No.13, Basic Type CC3C3C6C6",200,50);
     textFont(font,16);
     text("Turn the arbitrary line AC around A by 120 degrees into the position AB. "
    + "Draw from B towards an arbitrary point D the arbitrary line BD "
    + "and turn it around D in the same turning direction by 60 degrees in the position DE. "
    + "Complete the figure by a C-line EC. "
         , 200, 100,700,200);
     text("Number of arbitrary lines: 3\nNetwork: 63333\n6 Positions."
         , 650, 200, 700, 100); 
  popStyle();
}


