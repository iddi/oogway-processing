
void drawPoints(){
  pushStyle();
  o.pushState();
  textFont(font,16);
  textAlign(CENTER, CENTER);
  fill(255,0,55);
  o.setPenColor(0,0,255);
  
  drawPoint("A", Ax, Ay, -15, 15);
  drawPoint("B", Bx, By, 15, 15);  
  drawPoint("C", Cx, Cy, 15, -15);  
  drawPoint("D", Dx, Dy, -15, -15);
  drawPoint("E", Ex, Ey, 15, 0);
  drawPoint("F", Fx, Fy, -15, 0);

  drawPoint("M1", (Fx+Ax)/2, (Fy+Ay)/2, 25, 0);  
  drawPoint("M2", (Fx+Dx)/2, (Fy+Dy)/2, -25, 0);   
  drawPoint("M3", (Bx+Ex)/2, (By+Ey)/2, 15, -20);  
  drawPoint("M4", (Cx+Ex)/2, (Cy+Ey)/2, 0, -20);  
 

  o.popState();
  popStyle();
}

void drawPoint(String text, float x, float y, float a, float b){
    ellipse(x, y, 10 , 10);
    text(text, x+a, y + b);
}
