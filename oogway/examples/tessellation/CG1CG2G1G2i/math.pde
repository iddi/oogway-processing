/**
 *
 * three points. calculate the angle at (x2, y2).
 * Notice that this funciton always return a value that is <=180.
 */

float angleBetween(float x1, float y1, float x2, float y2, float x3, float y3) {

  float a = sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1));
  float b = sqrt((x2-x3)*(x2-x3)+(y2-y3)*(y2-y3));
  float c = sqrt((x1-x3)*(x1-x3)+(y1-y3)*(y1-y3));

  return degrees(acos((a*a +b*b -c*c) / (2*a*b)));
}

/**
 *  Line is (x1,y1) to (x2,y2), point is (x3,y3).
 *
 *  Find which side of a line a point is on. This can be done by assuming that 
 *  the line has a direction, pointing from its start to its end point. 
 *  a negative value ( < 0 ) if the point is "to the right" of the line, 
 *  zero ( == 0 ) if the point is on the line and a positive value ( > 0 ) if it's on "the left".
 */
boolean isLeft ( float x1, float y1, float x2, float y2, float x3, float y3 )
{
  return (x2 - x1) * (y3 - y1) - (y2 - y1) * (x3 - x1) > 0;
} 


boolean isRight ( float x1, float y1, float x2, float y2, float x3, float y3 )
{
  return (x2 - x1) * (y3 - y1) - (y2 - y1) * (x3 - x1) < 0;
} 

/**
 *
 * Find the intersection of two lines and move oogway to the intersection.
 * If two lines are COLLINEAR, this function will do nothing.
 *
 */

void toIntersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {

  float a1, a2, b1, b2, c1, c2;
  float denom, offset, num;
  float x, y;

  // Compute a1, b1, c1, where line joining points 1 and 2
  // is "a1 x + b1 y + c1 = 0".
  a1 = y2 - y1;
  b1 = x1 - x2;
  c1 = (x2 * y1) - (x1 * y2);

  // Compute a2, b2, c2
  a2 = y4 - y3;
  b2 = x3 - x4;
  c2 = (x4 * y3) - (x3 * y4);

  //Line segments intersect: compute intersection point.
  denom = (a1 * b2) - (a2 * b1);

  if (denom == 0) {
    return; // COLLINEAR, do nothing.
  }

  if (denom < 0) { 
    offset = -denom / 2;
  } 
  else {
    offset = denom / 2 ;
  }

  // The denom/2 is to get rounding instead of truncating. It
  // is added or subtracted to the numerator, depending upon the
  // sign of the numerator.
  num = (b1 * c2) - (b2 * c1);
  if (num < 0) {
    x = (num - offset) / denom;
  } 
  else {
    x = (num + offset) / denom;
  }

  num = (a2 * c1) - (a1 * c2);
  if (num < 0) {
    y = ( num - offset) / denom;
  } 
  else {
    y = (num + offset) / denom;
  }

  // lines_intersect
  o.setPosition(x, y);
}


