//targetX and targetY together determine the midpoint of a line x1,y1 to x2,y2

float targetX(float x1, float x2) {
  float bigX = x1;
  float smallX = x2;
  if (smallX > bigX) {
    float tempX = smallX;
    smallX = bigX;
    bigX = tempX;
  }

  return (bigX-smallX)/2+smallX;

}

float targetY(float y1, float y2) {
  float bigY = y1;
  float smallY = y2;
  if (smallY > bigY) {
    float tempY = smallY;
    smallY = bigY;
    bigY = tempY;
  }
  return (bigY-smallY)/2+smallY;
}