
void drawAxes() {
  pushStyle();
  o.pushState();
  textFont(font, 16);
  textAlign(CENTER, CENTER);
  fill(255, 0, 55);
  o.setPenColor(0, 0, 255);
  
  float s = AB/4;
  
  float H1x = Ax*(1-ratioAH1) + Bx*ratioAH1, H1y = Ay*(1-ratioAH1) + By*ratioAH1;
  float I1x = Cx*(1-ratioAH1) + Dx*ratioAH1, I1y = Cy*(1-ratioAH1) + Dy*ratioAH1;

  float H2x = Fx*(1-ratioBI2) + Ex*ratioBI2, H2y = Fy*(1-ratioBI2) + Ey*ratioBI2;  
  float I2x = Bx*(1-ratioBI2) + Cx*ratioBI2, I2y = By*(1-ratioBI2) + Cy*ratioBI2;
  
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
