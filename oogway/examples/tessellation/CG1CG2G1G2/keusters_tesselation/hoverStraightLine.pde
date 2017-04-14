boolean hoverStraightLine(float x1, float y1, float x2, float y2) {
  float m = (y2-y1)/(x2-x1); //calculate slope

  float Y = m*(mouseX - x1) + y1; //calculate Y based on mouseX
  float X = (mouseY - y1)/m + x1; //calculate X based on mouseY
  float xBig;
  float xSmall;
  float yBig;
  float ySmall;
  if (x1 > x2) { //determine which x is biggest
    xBig = x1;
    xSmall = x2;
  } else {
    xBig = x2;
    xSmall = x1;
  }
  if (y1 > y2) { //determine which y is biggest
    yBig = y1;
    ySmall = y2;
  } else {
    yBig = y2;
    ySmall = y1;
  }
  if (m >= -1 && m <= 1) { // if slope is between -1 and 1 look at Y value, otherwise look at X value
    if (mouseY < Y + 5 && mouseY > Y - 5 && mouseX < xBig && mouseX > xSmall) { // compare mouseY with Y value
      return true;
    } else { 
      return false;
    }
  } else {
    if (mouseX < X + 5 && mouseX > X - 5 && mouseY < yBig && mouseY > ySmall) { // compare mouseX with X value
      return true;
    } else {
      return false;
    }
  }

}