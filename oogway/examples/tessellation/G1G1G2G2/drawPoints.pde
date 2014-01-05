
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


