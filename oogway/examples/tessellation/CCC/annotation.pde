
void drawIntro(){
  pushStyle();
  fill(0);
     textFont(font,32);
     text("No.3, Basic Type CCC",200,50);
     textFont(font,16);
     text("Let AB be a C-line. Draw from A another, and from B a third C-line towards the point C, "
     + "which is chosen freely (but not lying on the straight line through A and B)."
         , 200, 100,700,200); 
     text("Number of arbitrary lines: 3\nNetwork: 666\n2 Positions"
         , 650, 200,700,100); 
  popStyle();
}

void drawArrow(float scale) {
  o.pushState();

  //o.setPosition((Ax+Bx+Cx+Dx+Ex+Fx)/6, (Ay+By+Cy+Dy+Ey+Fy)/6);
  //o.setPosition((Ax+Bx+Cx+Dx+Ex)/5, (Ay+By+Cy+Dy+Ey)/5);
  //o.setPosition((Ax+Bx+Cx+Dx)/4, (Ay+By+Cy+Dy)/4);
  o.setPosition((Ax+Bx+Cx)/3, (Ay+By+Cy)/3);

  o.setHeading(o.towards((Ax+Bx)/2, (Ay+By)/2));
  if (o.isReflecting()) {
    o.setStamp("arrow-reflected.svg");
  }
  else {
    o.setStamp("arrow.svg");
  }
  
  o.stamp(16*scale);

  o.popState();
} 


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

void highlightGroup(float scale){
  o.pushState();
  o.setPenColor(0,0,255);
  groupPositions(scale);
  o.popState();
}

void showGrid(){
  pushStyle();
  stroke(128);
  float x = 0, y = 0;
  fill(128);
  textFont(font,16);
  while(y<height){
    y +=100;
    text((int)y, 10, y );
    text((int)y, width-40, y );
    line(0, y, width, y);    
  }
  while(x<width){
    x+=100;
    text((int)x, x, 20 );
    text((int)x, x, height-15 );
    line(x, 0, x, height);
  }
  popStyle();
}
