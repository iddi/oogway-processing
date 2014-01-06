
//three points. calculate the angle at (x2, y2).
//Notice that this funciton always return a value that is <=180.

float findAngle(float x1, float y1, float x2, float y2, float x3, float y3) {
  
  float a = sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1));
  float b = sqrt((x2-x3)*(x2-x3)+(y2-y3)*(y2-y3));
  float c = sqrt((x1-x3)*(x1-x3)+(y1-y3)*(y1-y3));
  
  return degrees(acos((a*a +b*b -c*c) / (2*a*b)));
}

