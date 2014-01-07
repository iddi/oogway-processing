
void drawIntro() {
  pushStyle();
  textFont(font, 32);
  fill(0);
  text(title, 200, 50);
  textFont(font, 16);
  text(annotation, 200, 100, 700, 200);
  popStyle();
}

void drawPoint(float x, float y, float size) {
  pushStyle();
  fill(255, 0, 55);
  stroke(0, 0, 255);
  strokeWeight(1);

  ellipse(x, y, size, size);

  popStyle();
}

void drawMPoint(float x, float y, float size) {
  pushStyle();
  fill(255, 255, 255);
  stroke(0, 0, 255);
  strokeWeight(1);

  ellipse(x, y, size, size);

  popStyle();
}

void annotateText(String text, float x, float y) {
  pushStyle();
  textFont(font, 16);
  textAlign(CENTER, CENTER);
  fill(255, 0, 55);

  text(text, x, y);

  popStyle();
}

void drawArrow(float scale) {
  o.pushState();

  //o.setPosition((Ax+Bx+Cx+Dx+Ex+Fx)/6, (Ay+By+Cy+Dy+Ey+Fy)/6);
  //o.setPosition((Ax+Bx+Cx+Dx+Ex)/5, (Ay+By+Cy+Dy+Ey)/5);
  o.setPosition((Ax+Bx+Cx+Dx)/4, (Ay+By+Cy+Dy)/4);
  //o.setPosition((Ax+Bx+Cx)/3, (Ay+By+Cy)/3);

  o.setHeading(o.towards((Ax+Bx)/2, (Ay+By)/2));
  if (o.isReflecting()) {
    o.setStamp("arrow-reflected.svg");
  }
  else {
    o.setStamp("arrow.svg");
  }
  
  o.stamp(24*scale);

  o.popState();
} 

void highlightGroup(float scale){
  o.pushState();
  o.setPenColor(0,0,255);
  groupPositions(scale);
  o.popState();
}

void showGrid() {
  pushStyle();
  stroke(128);
  float x = 0, y = 0;
  fill(128);
  textFont(font, 16);
  while (y<height) {
    y +=100;
    text((int)y, 10, y );
    text((int)y, width-40, y );
    line(0, y, width, y);
  }
  while (x<width) {
    x+=100;
    text((int)x, x, 20 );
    text((int)x, x, height-15 );
    line(x, 0, x, height);
  }
  popStyle();
}

