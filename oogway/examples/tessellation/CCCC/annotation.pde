
void drawIntro(){
  pushStyle();
     textFont(font,32);
     fill(0);
     text("No.4, Basic Type CCCC",200,50);
     textFont(font,16);
     text("Let AB and BC be two mutually independent C-lines with the common endpoint B. Draw from C an arbitrary"
    + "third and from A another arbitrary fourth C-line towards the freely selected point D. "
         , 200, 100,700,200); 
     text("Number of arbitrary lines: 4\nNetwork: 4444\n2 Positions"
         , 650, 180,700,100); 
         popStyle();
}



void drawArrow(float scale) {
  o.pushState();

  //o.setPosition((Ax+Bx+Cx+Dx+Ex+Fx)/6, (Ay+By+Cy+Dy+Ey+Fy)/6);
  //o.setPosition((Ax+Bx+Cx+Dx+Ex)/5, (Ay+By+Cy+Dy+Ey)/5);
  o.setPosition((Ax+Bx+Cx+Dx)/4, (Ay+By+Cy+Dy)/4);
  //o.setPosition((Ax+Bx+Cx)/3, (Ay+By+Cy)/3);

  o.setHeading(o.towards((Cx+Bx)/2, (Cy+By)/2));
  if (o.isReflecting()) {
    o.setStamp("arrow-reflected.svg");
  }
  else {
    o.setStamp("arrow.svg");
  }
  
  o.stamp(24*scale);

  o.popState();
} 


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
