
void drawPoints(){
  pushStyle();
  o.pushState();
  textFont(font,16);
  textAlign(CENTER, CENTER);
  fill(255,0,55);
  o.setPenColor(0,0,255);
  
  drawPoint("A", Ax, Ay, 0, -20);
  drawPoint("B", Bx, By, 0, 15);  
  drawPoint("C", Cx, Cy, 15, 0);  
 
  
  drawPoint("M1", (Ax+Bx)/2, (Ay+By)/2, -20, 0);
  drawPoint("M2", (Cx+Bx)/2, (Cy+By)/2, 20, 0); 
  drawPoint("M3", (Cx+Ax)/2, (Cy+Ay)/2, 0, -20);      
 

  o.popState();
  popStyle();
}

void drawPoint(String text, float x, float y, float a, float b){
    ellipse(x, y, 10 , 10);
    text(text, x+a, y + b);
}
