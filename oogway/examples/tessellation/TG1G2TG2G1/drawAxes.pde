
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
  o.dashForward(o.distance(Ex, Ey));
  text("I1", o.xcor(), o.ycor()+10);
  o.setPosition(H1I1x, H1I1y);
  o.dashBackward(o.distance(Fx,Fy));
  text("H1", o.xcor(), o.ycor()+10);
  
  float H2I2x = (Dx+Ex)/2, H2I2y = (Dy+Ey)/2;
  o.setPosition(H2I2x, H2I2y);
  o.dashForward(o.distance(Ex, Ey));
  text("I2", o.xcor(), o.ycor()-15);
  o.setPosition(H2I2x, H2I2y);
  o.dashBackward(o.distance(Fx,Fy));
  text("H2", o.xcor(), o.ycor()-15);  

  o.popState();
  popStyle();
}
