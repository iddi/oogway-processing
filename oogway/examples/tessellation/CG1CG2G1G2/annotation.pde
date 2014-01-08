
void drawIntro() {
  pushStyle();
  textFont(font, 32);
  fill(0);
  text("No.28, Basic Type CG1CG2G1G2", 200, 50);
  textFont(font, 16);
  text("Glide-reflect the arbitrary line AB to CD (glide-reection axis H1I1). "
  +"Draw the arbitrary line BC and glide-reflect it in the glide-reection axis H2I2 "
  + "which is perpendicular to H1I1, towards FE (E arbitrary.) "
  + "Connect D to F by a C-line and connect A to E in the same way."
    , 200, 100, 700, 200);
  text("Number of arbitrary lines: 4\nNetwork: 333333\n4 Positions."
    , 650, 200, 700, 100); 
  popStyle();
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
  drawPoint("F", Fx, Fy, -15, 0);
  
  drawPoint("M1", (Dx+Fx)/2, (Dy+Fy)/2, -20, 0);
  drawPoint("M2", (Ax+Ex)/2, (Ay+Ey)/2, -20, 0);

  o.popState();
  popStyle();
}

void drawPoint(String text, float x, float y, float a, float b) {
  ellipse(x, y, 10, 10);
  text(text, x+a, y + b);
}


void drawArrow(float scale) {
  o.pushState();

  //o.setPosition((Ax+Bx+Cx+Dx+Ex+Fx)/6, (Ay+By+Cy+Dy+Ey+Fy)/6);
  //o.setPosition((Ax+Bx+Cx+Dx+Ex)/5, (Ay+By+Cy+Dy+Ey)/5);
  o.setPosition((Ax+Bx+Cx+Dx)/4, (Ay+By+Cy+Dy)/4);
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

void drawAxes() {
  pushStyle();
  o.pushState();
  textFont(font, 16);
  textAlign(CENTER, CENTER);
  fill(255, 0, 55);
  o.setPenColor(0, 0, 255);
  
  float H1x = Ax*(1-ratioAH1) + Bx*ratioAH1, H1y = Ay*(1-ratioAH1) + By*ratioAH1;
  float I1x = Cx*(1-ratioAH1) + Dx*ratioAH1, I1y = Cy*(1-ratioAH1) + Dy*ratioAH1;

  float H2x = Fx*(1-ratioBI2) + Ex*ratioBI2, H2y = Fy*(1-ratioBI2) + Ey*ratioBI2;  
  float I2x = Bx*(1-ratioBI2) + Cx*ratioBI2, I2y = By*(1-ratioBI2) + Cy*ratioBI2;
  
  float s = max(dist(H1x, H1y, I1x, I1y), dist(H2x, H2y, I2x, I2y))/4;
  
  o.setPosition(H1x, H1y);
  o.setHeading(o.towards(I1x, I1y));
  o.shiftBackward(s);
  text("H1", o.xcor()+15, o.ycor());
  o.dashForward(o.distance(I1x, I1y)+s);
  text("I1", o.xcor()+15, o.ycor());  
  
  o.setPosition(H2x, H2y);
  o.setHeading(o.towards(I2x, I2y));
  o.shiftBackward(s);
  text("H2", o.xcor()-15, o.ycor()-15);
  o.dashForward(o.distance(I2x, I2y)+s);
  text("I2", o.xcor(), o.ycor()-15);  


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

