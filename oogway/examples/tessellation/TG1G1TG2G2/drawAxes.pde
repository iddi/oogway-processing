
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
