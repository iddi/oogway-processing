
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



void drawArrow(float scale) {
  o.pushState();

  o.setPosition((Ax+Bx+Cx+Dx+Ex+Fx)/6, (Ay+By+Cy+Dy+Ey+Fy)/6);
  //o.setPosition((Ax+Bx+Cx+Dx+Ex)/5, (Ay+By+Cy+Dy+Ey)/5);
  //o.setPosition((Ax+Bx+Cx+Dx)/4, (Ay+By+Cy+Dy)/4);
  //o.setPosition((Ax+Bx+Cx)/3, (Ay+By+Cy)/3);

  o.setHeading(o.towards((Ax+Bx)/2, (Ay+By)/2));
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
  
  drawPoint("A", Ax, Ay, -15, 15);
  drawPoint("B", Bx, By, 15, 15);  
  drawPoint("C", Cx, Cy, 15, -15);  
  drawPoint("D", Dx, Dy, -15, -15);
  drawPoint("E", Ex, Ey, 15, 0);
  drawPoint("F", Fx, Fy, -15, 0);

  drawPoint("M1", (Fx+Ax)/2, (Fy+Ay)/2, 25, 0);  
  drawPoint("M2", (Fx+Dx)/2, (Fy+Dy)/2, -25, 0);   
  drawPoint("M3", (Bx+Ex)/2, (By+Ey)/2, 15, -20);  
  drawPoint("M4", (Cx+Ex)/2, (Cy+Ey)/2, 0, -20);  
 

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
