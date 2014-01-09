
void drawIntro() {
  pushStyle();
  textFont(font, 32);
  fill(0);
  text("No.20, Basic Type TG1G2TG2G1", 200, 50);
  textFont(font, 16);
  text("Shift the arbitrary line AB to DC, "
    + "glide-reflect another arbitrary line AF (F arbitrary) into EB. "
    + "Glide-reflect a third arbitrary line FD into CE. "
    + "(glide-reflection axes H1I1, H2I2 perpendicular to AD at equal "
    + "distances from B and F, and from D and E, respectively.)"
    , 200, 100, 700, 200);
  text("Number of arbitrary lines: 3\nNetwork: 333333\n2 Positions."
    , 650, 200, 700, 100); 
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


void drawPoints() {
  pushStyle();
  o.pushState();
  textFont(font, 16);
  textAlign(CENTER, CENTER);
  fill(255, 0, 55);
  o.setPenColor(0, 0, 255);

  drawPoint("A", Ax, Ay, 0, 15);
  drawPoint("B", Bx, By, 0, 15);  
  drawPoint("C", Cx, Cy, 0, -20);
  drawPoint("D", Dx, Dy, 0, -20); 
  drawPoint("E", Ex, Ey, 15, 0); 
  drawPoint("F", Fx, Fy, -15, 0); 

  o.popState();
  popStyle();
}

void drawPoint(String text, float x, float y, float a, float b) {
  ellipse(x, y, 10, 10);
  text(text, x+a, y + b);
}



void drawAxes() {
  pushStyle();
  o.pushState();
  textFont(font, 16);
  textAlign(CENTER, CENTER);
  fill(255, 0, 55);
  o.setPenColor(0, 0, 255);
  
  o.setPosition(Ax, Ay);
  o.setHeading(o.towards(Dx, Dy));
  o.dashForward(o.distance(Dx, Dy));
  o.right(90);
  
  float H1I1x = (Fx+Bx)/2, H1I1y = (Fy+By)/2;
  o.setPosition(H1I1x, H1I1y);
  o.shiftForward(100);
  
  toIntersection(o.xcor(), o.ycor(), H1I1x, H1I1y, Bx, By, Ex, Ey);
  float I1x = o.xcor(), I1y = o.ycor();
  toIntersection(o.xcor(), o.ycor(), H1I1x, H1I1y, Ax, Ay, Fx, Fy);
  float H1x = o.xcor(), H1y = o.ycor();
 
  float s = dist(H1x, H1y, I1x, I1y);
  
  o.setPosition(I1x, I1y);
  o.shiftForward(s/4);
  text("I1", o.xcor(), o.ycor()+10);
  o.dashBackward(s + s/2);
  text("H1", o.xcor(), o.ycor()+10);
  
  float H2I2x = (Dx+Ex)/2, H2I2y = (Dy+Ey)/2;
  o.setPosition(H2I2x, H2I2y);
  o.shiftForward(100);
  
  toIntersection(o.xcor(), o.ycor(), H2I2x, H2I2y, Cx, Cy, Ex, Ey);
  float I2x = o.xcor(), I2y = o.ycor();
  toIntersection(o.xcor(), o.ycor(), H2I2x, H2I2y, Dx, Dy, Fx, Fy);
  float H2x = o.xcor(), H2y = o.ycor();
 
  s = dist(H2x, H2y, I2x, I2y);
  
  o.setPosition(I2x, I2y);
  o.shiftForward(s/4);
  text("I2", o.xcor(), o.ycor()+10);
  o.dashBackward(s + s/2);
  text("H2", o.xcor(), o.ycor()+10);
  o.popState();
  popStyle();
}

void highlightGroup(float scale){
  o.pushState();
  o.setPenColor(0,0,255);
  groupPositions(scale);
  o.popState();
}

void showGrid() {
  pushStyle();
  stroke(128);
  float x = 0, y = 0;
  fill(128);
  textFont(font, 16);
  while (y<height) {
    y +=100;
    text((int)y, 10, y );
    text((int)y, width-40, y );
    line(0, y, width, y);
  }
  while (x<width) {
    x+=100;
    text((int)x, x, 20 );
    text((int)x, x, height-15 );
    line(x, 0, x, height);
  }
  popStyle();
}

