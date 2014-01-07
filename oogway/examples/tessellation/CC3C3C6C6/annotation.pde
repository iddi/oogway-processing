
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



void drawArrow(float scale) {
  o.pushState();

  //o.setPosition((Ax+Bx+Cx+Dx+Ex+Fx)/6, (Ay+By+Cy+Dy+Ey+Fy)/6);
  o.setPosition((Ax+Bx+Cx+Dx+Ex)/5, (Ay+By+Cy+Dy+Ey)/5);
  //o.setPosition((Ax+Bx+Cx+Dx)/4, (Ay+By+Cy+Dy)/4);
  //o.setPosition((Ax+Bx+Cx)/3, (Ay+By+Cy)/3);

  o.setHeading(o.towards(Ax, Ay));
  o.shiftForward(o.distance(Ax, Ay)/2);
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
  drawPoint("B", Bx, By, -15, 0);  
  drawPoint("C", Cx, Cy, 15, 0);  
  drawPoint("D", Dx, Dy, 15, 0);  
  drawPoint("E", Ex, Ey, 15, 0); 
  
  drawPoint("M", (Ex+Cx)/2, (Ey+Cy)/2, 15, 15);


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

