
void drawPoints() {
  pushStyle();
  o.pushState();
  textFont(font, 16);
  textAlign(CENTER, CENTER);
  fill(255, 0, 55);
  o.setPenColor(0, 0, 255);

  drawPoint("A", Ax, Ay, 0, 15);
  drawPoint("B", Bx, By, 15, 0);  
  drawPoint("C", Cx, Cy, 0, -20);
  drawPoint("D", Dx, Dy, -15, 0); 
  //drawPoint("E", Ex, Ey, -15, 0); 
  //drawPoint("F", Fx, Fy, 15, 0); 
  
  drawPoint("M1", (Ax+Dx)/2, (Ay+Dy)/2, -20, 0);
  drawPoint("M2", (Cx+Dx)/2, (Cy+Dy)/2, -20, 0);

  o.popState();
  popStyle();
}

void drawPoint(String text, float x, float y, float a, float b) {
  ellipse(x, y, 10, 10);
  text(text, x+a, y + b);
}


