
void drawIntro(){
  pushStyle();
     textFont(font,32);
     fill(0);
     text("No.1, Basic Type TTTT",200,50);
     textFont(font,16);
     text("Shift the arbitrary line AB to DC, such that ABCD are the corners of a parallelogram "
    + "(Translation vector AD). Draw another arbitrary line from A to D and shift it into the position "
    + "BC (translation vector AB)."
         , 200, 100,700,200); 
     text("Number of arbitrary lines: 2\nNetwork: 4444\n1 Position."
         , 650, 200,700,100); 
         popStyle();
}
