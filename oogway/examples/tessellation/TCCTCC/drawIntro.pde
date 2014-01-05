
void drawIntro(){
  pushStyle();
     textFont(font,32);
     fill(0);
     text("No.7, Basic Type TCCTCC",200,50);
     textFont(font,16);
     text("Shift the arbitrary line AB to DC. Draw from A a C-line to the arbitrary point F;"
    + " connect F by a second C-line to D. "
    + "Draw a third C-line from B to the freely chosen point E and close the figure by means of a fourth C-line CE. "
         , 200, 100,700,200); 
     text("Number of arbitrary lines: 4\nNetwork: 333333,\n2 Positions."
         , 650, 180,700,100); 
  popStyle();
}


