//Checks whether a dot is hovered

boolean hoverDots(float x, float y) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < 10 ) {
    return true;
  } else {
    return false;
  }
}