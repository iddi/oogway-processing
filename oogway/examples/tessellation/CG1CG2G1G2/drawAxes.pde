
void drawAxes() {
  pushStyle();
  o.pushState();
  textFont(font, 16);
  textAlign(CENTER, CENTER);
  fill(255, 0, 55);
  o.setPenColor(0, 0, 255);
  
  o.setPosition(Ax, Ay);
  o.setHeading(o.towards(Dx, Dy));

  float H1I1x = (Ax+Cx)/2, H1I1y = (Ay+Cy)/2;
  o.setPosition(H1I1x, H1I1y);
  o.dashForward(o.distance(Dx, Dy));
  text("H1", o.xcor()+15, o.ycor());
  o.setPosition(H1I1x, H1I1y);
  o.dashBackward(o.distance(Ax,Ay));
  text("I1", o.xcor()+15, o.ycor());
  
  o.setPosition(H1I1x, H1I1y);
  o.left(90);  
  
  o.dashForward(o.distance(Dx, Dy));
  text("H2", o.xcor()-15, o.ycor());
  o.setPosition(H1I1x, H1I1y);
  o.dashBackward(o.distance(Cx,Cy));
  text("I2", o.xcor()+15, o.ycor());

  o.popState();
  popStyle();
}
