
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


void drawArrow(float scale) {
  o.pushState();

  o.setPosition((Ax+Bx+Cx+Dx+Ex+Fx)/6, (Ay+By+Cy+Dy+Ey+Fy)/6);
  //o.setPosition((Ax+Bx+Cx+Dx+Ex)/5, (Ay+By+Cy+Dy+Ey)/5);
  //o.setPosition((Ax+Bx+Cx+Dx)/4, (Ay+By+Cy+Dy)/4);
  //o.setPosition((Ax+Bx+Cx)/3, (Ay+By+Cy)/3);

  o.setHeading(o.towards(Ax, Ay));
  if (o.isReflecting()) {
    o.setStamp("arrow-reflected.svg");
  }
  else {
    o.setStamp("arrow.svg");
  }
  
  o.stamp(24*scale);

  o.popState();
} 



void drawPoints(){
  pushStyle();
  o.pushState();
  textFont(font,16);
  textAlign(CENTER, CENTER);
  fill(255,0,55);
  o.setPenColor(0,0,255);
  
  drawPoint("A", Ax, Ay, -15, 0);
  drawPoint("B", Bx, By, 0, -15);  
  drawPoint("C", Cx, Cy, 0, 15);  
  drawPoint("D", Dx, Dy, 0, 15);
  drawPoint("E", Ex, Ey, 15, 0);  
  drawPoint("F", Fx, Fy, 15, 0);
 

  o.popState();
  popStyle();
}

void drawPoint(String text, float x, float y, float a, float b){
    ellipse(x, y, 10 , 10);
    text(text, x+a, y + b);
}

void highlightGroup(float scale){
  o.pushState();
  o.setPenColor(0,0,255);
  groupPositions(scale);
  o.popState();
}

void showGrid(){
  pushStyle();
  stroke(128);
  float x = 0, y = 0;
  fill(128);
  textFont(font,16);
  while(y<height){
    y +=100;
    text((int)y, 10, y );
    text((int)y, width-40, y );
    line(0, y, width, y);    
  }
  while(x<width){
    x+=100;
    text((int)x, x, 20 );
    text((int)x, x, height-15 );
    line(x, 0, x, height);
  }
  popStyle();
}

