
void drawIntro(){
  pushStyle();
     textFont(font,32);
     fill(0);
     text("No.9, Basic Type C3C3C3C3C3C3",200,50);
     textFont(font,16);
     text("Turn the arbitrary line AB by 120 degrees into the position AC."
    + " Turn another arbitrary line CD(D arbitrary) around D by 120 degrees into the position DE."
    + " F is the third corner of the equilateral triangle ADF, the angle EFB being equal to 120 degrees."
    + " Turn a third arbitrary line FE around F by 120 degrees into the position FB."
         , 200, 100,700,200);
     text("Number of arbitrary lines: 3\nNetwork: 333333,\n3 Positions."
         , 650, 200,700,100); 
  popStyle();
}

