
void drawPoints(){
  pushStyle();
  o.pushState();
  textFont(font,16);
  textAlign(CENTER, CENTER);
  fill(255,0,55);
  o.setPenColor(0,0,255);
  
  drawPoint("A", Ax, Ay, 15, 0);
  drawPoint("B", Bx, By, -15, 0);  
  drawPoint("C", Cx, Cy, 0, 15);  
  drawPoint("D", Dx, Dy, 15, 0);

  drawPoint("M1", (Ax+Bx)/2, (Ay+By)/2, 0, -25);
  drawPoint("M2", (Bx+Cx)/2, (By+Cy)/2, -25, 0);  
  drawPoint("M3", (Cx+Dx)/2, (Cy+Dy)/2, 25, 0);  
  drawPoint("M4", (Dx+Ax)/2, (Dy+Ay)/2, 25, 0);    
 

  o.popState();
  popStyle();
}

void drawPoint(String text, float x, float y, float a, float b){
    ellipse(x, y, 10 , 10);
    text(text, x+a, y + b);
}

