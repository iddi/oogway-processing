
void drawIntro(){
  pushStyle();
     textFont(font,32);
     fill(0);
     text("No.6, Basic Type TCTCC",200,50);
     textFont(font,16);
     text("Shift the arbitrary line AB to DC so that ABCD are the corners of a parallelogram. Connect A to D using a C-line. "
    + "Draw one more C-line from B to arbitrary point E. Complete the figure with a third, also arbitrary C-line CE. "
         , 200, 100,700,200); 
     text("Number of arbitrary lines: 4\nNetwork: 44333,\n2 Positions."
         , 650, 180,700,100); 
         popStyle();
}

