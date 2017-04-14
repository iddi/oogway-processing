float polynomial(float x0, float x1, float x2, float x3, float t) {
  //sum of binomials (4 over 0,1,2,3, respectively) times polynomial in t 
  return x0     * pow((1-t),3)
    + x1 * 3 * pow((1-t),2) * t
    + x2 * 3 * (1-t) * pow(t,2)
    + x3     * pow(t,3);
}

void bezierCurve(float x1, float y1, float x2, float y2, float xc1, float yc1, float xc2, float yc2) {
  float prev_x = x1;
  float prev_y = y1;
  bezierHover = false;

  for (int i=0; i < 100; i++) {  //draw bezier curve in 100 steps
    float t = i * 0.01;
    float x = polynomial(x1, xc1, xc2, x2, t); //determine x for current i
    float y = polynomial(y1, yc1, yc2, y2, t); //determine y for current i
    line(prev_x, prev_y, x, y);  //draw 1/100 of the curve
    stroke(0);

    prev_x = x; //make current x prev_x
    prev_y = y; //make current y prev_y
    if (mouseX < x + 5 && mouseX > x - 5 && mouseY < y + 5 && mouseY > y-5) { //check whether mouseX and mouseY are hovering the curve
      bezierHover = true;
    }
  }
}