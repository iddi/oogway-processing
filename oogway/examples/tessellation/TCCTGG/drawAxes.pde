
void drawAxes() {
  pushStyle();
  o.pushState();
  textFont(font, 16);
  textAlign(CENTER, CENTER);
  fill(255, 0, 55);
  o.setPenColor(0, 0, 255);

  float N2x = (Bx+Cx)/2, N2y = (By+Cy)/2;
  o.setPosition(N2x, N2y);
  text("N", o.xcor()-10, o.ycor());
  
  o.setHeading(o.towards(Ex, Ey));
  o.dashForward(o.distance(Ex, Ey));
  
  o.setPosition(Bx, By);
  o.setHeading(o.towards(Cx, Cy));
  o.dashForward(o.distance(Cx, Cy));

  float H2I2x = (N2x+Ex)/2, H2I2y = (N2y+Ey)/2;
  o.setPosition(H2I2x, H2I2y);
  o.dashForward(o.distance(Cx, Cy));
  text("H", o.xcor()+15, o.ycor());
  o.setPosition(H2I2x, H2I2y);
  o.dashBackward(o.distance(Bx,By));
  text("I", o.xcor()+15, o.ycor());

  o.popState();
  popStyle();
}
