
void drawIntro() {
  pushStyle();
  textFont(font, 32);
  fill(0);
  text("No.18, Basic Type TG1G1TG2G2", 200, 50);
  textFont(font, 16);
  text("Shift the arbitrary line AB to DC. "
    + "Connect A to a point E on the perpendicular bisector of N1E of AD "
    + "by an arbitrary line and glide-reflect AE towards ED. "
    + "Complete the figure by another pair of glide-reflected and connected lines BF, FC; "
    + "F is on the perpendicular bisector FN2 of BC (glide-reflection axes H1I1 and H2I2)."
    , 200, 100, 700, 200);
  text("Number of arbitrary lines: 3\nNetwork: 333333\n2 Positions."
    , 650, 210, 700, 100); 
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
  drawPoint("E", Ex, Ey, -15, 0); 
  drawPoint("F", Fx, Fy, 15, 0); 

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

  float s = AD/2;

  float H1x = (Dx+Ex)/2, H1y = (Dy+Ey)/2;
  float I1x = (Ax+Ex)/2, I1y = (Ay+Ey)/2;

  float H2x = (Cx+Fx)/2, H2y = (Cy+Fy)/2;
  float I2x = (Bx+Fx)/2, I2y = (By+Fy)/2;

  //H1I1
  o.setPosition(H1x, H1y);
  o.setHeading(o.towards(I1x, I1y));
  o.shiftBackward(s);
  text("H1", o.xcor()-15, o.ycor()-15);
  o.dashForward(o.distance(I1x, I1y)+s);
  text("I1", o.xcor()-15, o.ycor());  

  //H2I2
  o.setPosition(H2x, H2y);
  o.setHeading(o.towards(I2x, I2y));
  o.shiftBackward(s);
  text("H2", o.xcor()+15, o.ycor()-15);
  o.dashForward(o.distance(I2x, I2y)+s);
  text("I2", o.xcor()+15, o.ycor()); 

  //AD
  o.setPosition(Ax, Ay);
  o.setHeading(o.towards(Dx, Dy));
  o.dashForward(o.distance(Dx, Dy));

  //BD
  o.setPosition(Bx, By);
  o.setHeading(o.towards(Cx, Cy));
  o.dashForward(o.distance(Cx, Cy));

  float N1x = (Ax+Dx)/2, N1y = (Ay+Dy)/2;
  float N2x = (Bx+Cx)/2, N2y = (By+Cy)/2;

  //EN1
  o.setPosition(Ex, Ey);
  o.setHeading(o.towards(N1x, N1y));
  o.dashForward(o.distance(N1x, N1y));
  text("N1", o.xcor()+15, o.ycor());  

  //FN2
  o.setPosition(Fx, Fy);
  o.setHeading(o.towards(N2x, N2y));
  o.dashForward(o.distance(N2x, N2y));
  text("N2", o.xcor()-15, o.ycor());  

  o.popState();
  popStyle();
}

void highlightGroup(float scale) {
  o.pushState();
  o.setPenColor(0, 0, 255);
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

