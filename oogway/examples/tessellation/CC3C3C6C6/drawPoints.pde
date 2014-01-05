
void drawPoints(){
  pushStyle();
  o.pushState();
  textFont(font,16);
  textAlign(CENTER, CENTER);
  fill(255,0,55);
  o.setPenColor(0,0,255);
  
  drawPoint("A", Ax, Ay, -15, 0);
  drawPoint("B", Bx, By, -15, 0);  
  drawPoint("C", Cx, Cy, 15, 0);  
  drawPoint("D", Dx, Dy, 15, 0);  
  drawPoint("E", Ex, Ey, 15, 0); 
  
  drawPoint("M", (Ex+Cx)/2, (Ey+Cy)/2, 15, 15);


  o.popState();
  popStyle();
}

void drawPoint(String text, float x, float y, float a, float b){
    ellipse(x, y, 10 , 10);
    text(text, x+a, y + b);
}
