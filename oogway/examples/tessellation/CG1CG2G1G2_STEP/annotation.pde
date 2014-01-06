
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

