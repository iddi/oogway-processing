//this function zooms in or out around the position of the mouse. When a = 1, the function will zoom in, for -1 it will zoom out.
//The function takes each control point and adjusts the distance to the coordinates of the mouse.

void resize(int a) {
  for (int i = 0; i < 4; i++) {
    for ( int j = 0; j < count[i]+1; j++) {
      allPoints[i][j][0] = (allPoints[i][j][0]-mouseX)*pow(zoomMag, a)+mouseX;
      allPoints[i][j][1] = (allPoints[i][j][1]-mouseY)*pow(zoomMag, a)+mouseY;
      bezierPoints[i][j][0][0] = (bezierPoints[i][j][0][0]-mouseX)*pow(zoomMag, a)+mouseX;
      bezierPoints[i][j][0][1] = (bezierPoints[i][j][0][1]-mouseY)*pow(zoomMag, a)+mouseY;
      bezierPoints[i][j][1][0] = (bezierPoints[i][j][1][0]-mouseX)*pow(zoomMag, a)+mouseX;
      bezierPoints[i][j][1][1] = (bezierPoints[i][j][1][1]-mouseY)*pow(zoomMag, a)+mouseY;
    }
  }
  pointE[0] = (pointE[0]-mouseX)*pow(zoomMag, a)+mouseX;
  pointE[1] = (pointE[1]-mouseY)*pow(zoomMag, a)+mouseY;
}