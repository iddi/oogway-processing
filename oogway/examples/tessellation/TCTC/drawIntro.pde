
void drawIntro(){
  pushStyle();
     textFont(font,32);
     fill(0);
     text("No.5, Basic Type TCTC",200,50);
     textFont(font,16);
     text("Shift the arbitrary line AB to DC so that drawPiece are the corners of a parallelogram. Connect A to D using a C-line."
    + "Place a second (independent of the previous) C-line (same end point distances) from B to C. "
         , 200, 100,700,200); 
     text("Number of arbitrary lines: 3\nNetwork: 4444,\n2 Positions."
         , 650, 180,700,100); 
         popStyle();
}


