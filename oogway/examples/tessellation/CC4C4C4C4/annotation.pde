
void drawIntro(){
  pushStyle();
     textFont(font,32);
     fill(0);
     text("No.16, Basic Type CC4C4C4C4",200,50);
     textFont(font,16);
     text("Turn the arbitrary line AB around A by 90 Degrees into the position AC. "
     + "Draw another arbitrary line from C to the arbitrary point D "
     + "and turn it 90 degrees into the position DE. "
     + "Complete the figure by a C-line EB."
        , 200, 100,700,200);
     text("Number of arbitrary lines: 2\nNetwork: 43433\n4 Positions."
         , 650, 200,700,100); 
  popStyle();
}


void drawArrow(float scale) {
  o.pushState();

  //o.setPosition((Ax+Bx+Cx+Dx+Ex+Fx)/6, (Ay+By+Cy+Dy+Ey+Fy)/6);
  o.setPosition((Ax+Bx+Cx+Dx+Ex)/5, (Ay+By+Cy+Dy+Ey)/5);
  //o.setPosition((Ax+Bx+Cx+Dx)/4, (Ay+By+Cy+Dy)/4);
  //o.setPosition((Ax+Bx+Cx)/3, (Ay+By+Cy)/3);

  o.setHeading(180+o.towards(Ax, Ay));
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
  
  drawPoint("A", Ax, Ay, 0, -20);
  drawPoint("B", Bx, By, 15, 0);  
  drawPoint("C", Cx, Cy, -15, 0);  
  drawPoint("D", Dx, Dy, -15, 15);  
  drawPoint("E", Ex, Ey, 15, 15);  
  
  drawPoint("M", (Ex+Bx)/2, (Ey+By)/2, 15, 15);  
 

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
