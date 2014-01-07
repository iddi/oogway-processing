
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
  
  float N1x = (Ax+Dx)/2, N1y = (Ay+Dy)/2;
  o.setPosition(N1x, N1y);
  text("N1", o.xcor()+15, o.ycor());
  
  o.setHeading(o.towards(Ex, Ey));
  o.dashForward(o.distance(Ex, Ey));
  
  o.setPosition(Ax, Ay);
  o.setHeading(o.towards(Dx, Dy));
  o.dashForward(o.distance(Dx, Dy));

  float H1I1x = (N1x+Ex)/2, H1I1y = (N1y+Ey)/2;
  o.setPosition(H1I1x, H1I1y);
  o.dashForward(o.distance(Dx, Dy));
  text("H1", o.xcor()-15, o.ycor());
  o.setPosition(H1I1x, H1I1y);
  o.dashBackward(o.distance(Ax,Ay));
  text("I1", o.xcor()-15, o.ycor());
  
  float N2x = (Bx+Cx)/2, N2y = (By+Cy)/2;
  o.setPosition(N2x, N2y);
  text("N2", o.xcor()-15, o.ycor());
  
  o.setHeading(o.towards(Fx, Fy));
  o.dashForward(o.distance(Fx, Fy));
  
  o.setPosition(Bx, By);
  o.setHeading(o.towards(Cx, Cy));
  o.dashForward(o.distance(Cx, Cy));

  float H2I2x = (N2x+Fx)/2, H2I2y = (N2y+Fy)/2;
  o.setPosition(H2I2x, H2I2y);
  o.dashForward(o.distance(Cx, Cy));
  text("H2", o.xcor()+15, o.ycor());
  o.setPosition(H2I2x, H2I2y);
  o.dashBackward(o.distance(Bx,By));
  text("I2", o.xcor()+15, o.ycor());

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

