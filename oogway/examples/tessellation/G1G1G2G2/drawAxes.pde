
void drawAxes() {
  pushStyle();
  o.pushState();
  textFont(font, 16);
  textAlign(CENTER, CENTER);
  fill(255, 0, 55);
  o.setPenColor(0, 0, 255);
  
  o.setPosition(Bx, By);
  o.setHeading(o.towards(Dx, Dy));
  o.dashForward(o.distance(Dx, Dy));
  o.right(90);

  float H1I1x = ((Ax+Cx)/2+Bx)/2, H1I1y = ((Ay+Cy)/2+By)/2;
  o.setPosition(H1I1x, H1I1y);
  o.dashForward(o.distance(Cx, Cy));
  text("H1", o.xcor(), o.ycor()+10);
  o.setPosition(H1I1x, H1I1y);
  o.dashBackward(o.distance(Ax,Ay));
  text("I1", o.xcor(), o.ycor()+10);
  
  float H2I2x = ((Ax+Cx)/2+Dx)/2, H2I2y = ((Ay+Cy)/2+Dy)/2;
  o.setPosition(H2I2x, H2I2y);
  o.dashForward(o.distance(Cx, Cy));
  text("H2", o.xcor(), o.ycor()-15);
  o.setPosition(H2I2x, H2I2y);
  o.dashBackward(o.distance(Ax,Ay));
  text("I2", o.xcor(), o.ycor()-15);  
  
  o.setPosition(Ax, Ay);
  o.setHeading(o.towards(Cx, Cy));
  o.dashForward(o.distance(Cx, Cy));

  o.setPosition(Bx, By);
  o.setHeading(o.towards(Dx, Dy));
  o.dashForward(o.distance(Dx, Dy));

  o.popState();
  popStyle();
}


