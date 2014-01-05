
void drawAxes() {
  pushStyle();
  o.pushState();
  textFont(font, 16);
  textAlign(CENTER, CENTER);
  fill(255, 0, 55);
  o.setPenColor(0, 0, 255);

  o.setPosition(Ax, Ay);
  o.setHeading(o.towards(Cx, Cy));

  float H1I1x = ((Ax+Cx)/2+Bx)/2, H1I1y = ((Ay+Cy)/2+By)/2;
  o.setPosition(H1I1x, H1I1y);
  o.dashForward(o.distance(Cx, Cy));
  text("H", o.xcor()+10, o.ycor());
  o.setPosition(H1I1x, H1I1y);
  o.dashBackward(o.distance(Ax,Ay));
  text("I", o.xcor()+10, o.ycor());
 
  o.popState();
  popStyle();
}
