
void drawIntro() {
  pushStyle();
  textFont(font, 32);
  fill(0);
  text("No.17, Basic Type G1G1G2G2", 200, 50);
  textFont(font, 16);
  text("Move the arbitrary line AB by glide-reflection so that it connects to BC "
    + "(glide-reflect axis H1I1 parallel to AC at the same distance from B as from A). "
    + "Draw one more arbitrary line CD, D being anywhere on the perpendicular bisector MD of AC. "
    + "Glide-reflect CD into the position DA so that it connects "
    + "(glide-reflection axis H2I2 parallel to H1I1 going through the midpoint K of DM)."
    , 200, 100, 700, 200);
  text("Number of arbitrary lines: 2\nNetwork: 4444\n2 Positions."
    , 650, 230, 700, 100); 
  popStyle();
}


void drawArrow(float scale) {
  o.pushState();

  //o.setPosition((Ax+Bx+Cx+Dx+Ex+Fx)/6, (Ay+By+Cy+Dy+Ey+Fy)/6);
  //o.setPosition((Ax+Bx+Cx+Dx+Ex)/5, (Ay+By+Cy+Dy+Ey)/5);
  o.setPosition((Ax+Bx+Cx+Dx)/4, (Ay+By+Cy+Dy)/4);
  //o.setPosition((Ax+Bx+Cx)/3, (Ay+By+Cy)/3);

  o.setHeading(o.towards(Dx, Dy));
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

  drawPoint("A", Ax, Ay, 15, 15);
  drawPoint("B", Bx, By, 15, -15);  
  drawPoint("C", Cx, Cy, -15, -15);  
  drawPoint("D", Dx, Dy, -15, 15); 
  
  o.setPosition((Ax+Bx+Cx+Dx)/4, (Ay+By+Cy+Dy)/4);
  text("M", o.xcor()-10, o.ycor()+20);

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
  
  float s = AB/2;
  
  float H1x = (Cx+Bx)/2, H1y = (Cy+By)/2;
  float I1x = (Ax+Bx)/2, I1y = (Ay+By)/2;

  float H2x = (Cx+Dx)/2, H2y = (Cy+Dy)/2;
  float I2x = (Ax+Dx)/2, I2y = (Ay+Dy)/2;
  
  //H1I1
  o.setPosition(H1x, H1y);
  o.setHeading(o.towards(I1x, I1y));
  o.shiftBackward(s);
  text("H1", o.xcor()-15, o.ycor()-15);
  o.dashForward(o.distance(I1x, I1y)+s);
  text("I1", o.xcor(), o.ycor()+15);  
  
  //H2I2
  o.setPosition(H2x, H2y);
  o.setHeading(o.towards(I2x, I2y));
  o.shiftBackward(s);
  text("H2", o.xcor()-15, o.ycor()-15);
  o.dashForward(o.distance(I2x, I2y)+s);
  text("I2", o.xcor(), o.ycor()+15); 
  
  //AC
  o.setPosition(Ax, Ay);
  o.setHeading(o.towards(Cx, Cy));
  o.dashForward(o.distance(Cx, Cy));
  
  //BD
  o.setPosition(Bx, By);
  o.setHeading(o.towards(Dx, Dy));
  o.dashForward(o.distance(Dx, Dy));

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

