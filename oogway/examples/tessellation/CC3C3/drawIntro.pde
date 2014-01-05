
void drawIntro(){
  pushStyle();
     textFont(font,32);
     fill(0);
     text("No.10, Basic Type CC3C3",200,50);
     textFont(font,16);
     text("Turn the arbitrary line AB around A by 120 degrees into the position AC."
    + " Connect B to the midpoint M of the segment BC by an arbitrary line"
    + " and turn it around M by 180 degrees into MC (by which BC becomes a C-line)."
         , 200, 100,700,200);
     text("Number of arbitrary lines: 2\nNetwork: 12,12,3\n6 Positions."
         , 650, 200,700,100); 
  popStyle();
}


