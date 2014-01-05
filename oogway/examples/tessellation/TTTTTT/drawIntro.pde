
void drawIntro(){
  pushStyle();
     textFont(font,32);
     fill(0);
     text("No.2, Basic Type TTTTTT",200,50);
     textFont(font,16);
     text("Shift the arbitrary line AB to DC. "
     + "Shift the arbitrary line AF (F arbitrary) to EC (Translation vector AE)."
     + "Move a third arbitrary line BE to FD (translation vector BF). "
         , 200, 100,700,200); 
     text("Number of arbitrary lines: 3\nNetwork: 333333\n1 Position"
         , 650, 200,700,100); 
         popStyle();
}
