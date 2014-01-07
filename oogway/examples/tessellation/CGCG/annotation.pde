
void drawIntro() {
  pushStyle();
  textFont(font, 32);
  fill(0);
  text("No.25, Basic Type CGCG", 200, 50);
  textFont(font, 16);
  text("Glide-reflect the arbitrary line AB into the position DC "
    + "(glide-reflection axis HI has the same distance from A and C, "
    + "another equal distance from B and D). "
    + " Connect A to D by a C-line, "
    + " and also connect B to C by yet another C-line."
    , 200, 100, 700, 200);
  text("Number of arbitrary lines: 3\nNetwork: 4444\n4 Positions."
    , 650, 180, 700, 100); 
  popStyle();
}


void drawArrow(float scale) {
  o.pushState();

  //o.setPosition((Ax+Bx+Cx+Dx+Ex+Fx)/6, (Ay+By+Cy+Dy+Ey+Fy)/6);
  //o.setPosition((Ax+Bx+Cx+Dx+Ex)/5, (Ay+By+Cy+Dy+Ey)/5);
  o.setPosition((Ax+Bx+Cx+Dx)/4, (Ay+By+Cy+Dy)/4);
  //o.setPosition((Ax+Bx+Cx)/3, (Ay+By+Cy)/3);

  o.setHeading(o.towards((Ax+Dx)/2, (Ay+Dy)/2));
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

  float H1I1x = (Ax+Cx)/2, H1I1y = (Ay+Cy)/2;
  o.setPosition(H1I1x, H1I1y);
  o.dashForward(o.distance(Cx, Cy));
  text("I", o.xcor(), o.ycor()+10);
  o.setPosition(H1I1x, H1I1y);
  o.dashBackward(o.distance(Ax,Ay));
  text("H", o.xcor(), o.ycor()+10);
  

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

