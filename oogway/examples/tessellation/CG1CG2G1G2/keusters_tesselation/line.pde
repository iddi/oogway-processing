void newLine(int lineNr, int reps) {
  float targetX;
  float targetY;  

  if (lineNr == 1) {     
    targetX = targetX(allPoints[lineNr][0][0], allPoints[lineNr+1][0][0]);
    targetY = targetY(allPoints[lineNr][0][1], allPoints[lineNr+1][0][1]);
  } else if (lineNr == 3) {
    targetX = targetX(allPoints[lineNr][0][0], pointE[0]);
    targetY = targetY(allPoints[lineNr][0][1], pointE[1]);
  } else {
    targetX = allPoints[lineNr+1][0][0];
    targetY = allPoints[lineNr+1][0][1];
  }

  //draws ellipses on all controll points

  if (reps == 0) { //only draw ellipses in the control lines
    fill(0);
    for (int i = 0; i < count[lineNr]+1; i++) {
      ellipse(allPoints[lineNr][i][0], allPoints[lineNr][i][1], 5, 5); 
      if (curve[lineNr][i]) {
        ellipse(bezierPoints[lineNr][i][1][0], bezierPoints[lineNr][i][1][1], 5, 5);
        ellipse(bezierPoints[lineNr][i][0][0], bezierPoints[lineNr][i][0][1], 5, 5);
      }

      if (mousePressed && hoverDots(allPoints[lineNr][i][0], allPoints[lineNr][i][1])) {
        allPoints[lineNr][i][0] = mouseX;
        allPoints[lineNr][i][1] = mouseY;
        dotsActive[lineNr] = true; //block hoverStraightLine()
      } 
      for (int j = 0; j < 2; j++) {
        if (mousePressed && hoverDots(bezierPoints[lineNr][i][j][0], bezierPoints[lineNr][i][j][1]) && curve[lineNr][i]) {
          bezierPoints[lineNr][i][j][0] = mouseX;
          bezierPoints[lineNr][i][j][1] = mouseY;
          dotsActive[lineNr] = true; //block hoverStraightLine()
        }
      }
    }
  }


  if (dotsActive[lineNr]&&!mousePressed) {
    dotsActive[lineNr] = false;
  }
  for (int i = 0; i < count[lineNr] + 1; i++) {
    if (i == count[lineNr]) { //this part draws the connecting line between different lines, for example the connection between allPoints[0][0][0],allPoints[0][0][1] and allPoints[1][0][0],allPoints[1][0][1], in the beginning of the program.
      if (!curve[lineNr][i]) { // if this line should not be a curve, draw a straight line, else draw a bezier curve. TargetX and targetY indicate the position to go to, for example, the starting point of the next line, a rotation point or the last point in the program.
        line(allPoints[lineNr][i][0], allPoints[lineNr][i][1], targetX, targetY);
      } else {
        bezierCurve(allPoints[lineNr][i][0], allPoints[lineNr][i][1], targetX, targetY, bezierPoints[lineNr][i][0][0], bezierPoints[lineNr][i][0][1], bezierPoints[lineNr][i][1][0], bezierPoints[lineNr][i][1][1]);
      }

      if (mousePressed && !keyPressed && hoverStraightLine(allPoints[lineNr][i][0], allPoints[lineNr][i][1], targetX, targetY) && !active[lineNr] && !dotsActive[lineNr]) { //checks whether the mouse is pressed while hovering a line, also it checks for the other requirements: key should not be pressed, the line shouldn't be already hovered after the mouse was clicked and none of the dots should be currently dragged.  
        active[lineNr] = true; //make line active; indicates that another control points should be added, the moment the mouse is released
        savePos[lineNr] = 9999; //impossible number = special case indicating this is the last line segment.
      }
      if (mousePressed && keyPressed && hoverStraightLine(allPoints[lineNr][i][0], allPoints[lineNr][i][1], targetX, targetY) && !active[lineNr] && !dotsActive[lineNr] && !curve[lineNr][i]) { // checks whether mouse is pressed AND any key is pressed, and if the line is a straight line.
        curve[lineNr][i] = true; //says this line is a curve
        stillPressed[lineNr] = true; //makes sure the program doesn't repeat this process untill the mouse is released.
        bezierPoints[lineNr][i][0][0] = (2*allPoints[lineNr][i][0]+targetX)/3; //bezier control points are added.
        bezierPoints[lineNr][i][0][1] = (2*allPoints[lineNr][i][1]+targetY)/3;
        bezierPoints[lineNr][i][1][0] = (2*targetX+allPoints[lineNr][i][0])/3;
        bezierPoints[lineNr][i][1][1] = (2*targetY+allPoints[lineNr][i][1])/3;
      }


      if (mousePressed && keyPressed & bezierHover && !stillPressed[lineNr] && !active[lineNr] && !dotsActive[lineNr] && curve[lineNr][i]) { // checks if the mouse and any key are pressed, and if this line is a curve.
        curve[lineNr][i] = false; // changes the curve to a straight line. 
      }
      
      
    } else //this part adresses all line segments except the last segment of each line
    {
      if (!curve[lineNr][i]) {//if this segment is no curve: draw a line 
        line(allPoints[lineNr][i][0], allPoints[lineNr][i][1], allPoints[lineNr][i+1][0], allPoints[lineNr][i+1][1]);
      } else { //if this segment is a curve: draw a bezier curve
        bezierCurve(allPoints[lineNr][i][0], allPoints[lineNr][i][1], allPoints[lineNr][i+1][0], allPoints[lineNr][i+1][1], bezierPoints[lineNr][i][0][0], bezierPoints[lineNr][i][0][1], bezierPoints[lineNr][i][1][0], bezierPoints[lineNr][i][1][1]);
      }
      if (mousePressed && !keyPressed && hoverStraightLine(allPoints[lineNr][i][0], allPoints[lineNr][i][1], allPoints[lineNr][i+1][0], allPoints[lineNr][i+1][1]) && !active[lineNr] && !dotsActive[lineNr]) { //checks whether the mouse is pressed while hovering a line, also it checks for the other requirements: key should not be pressed, the line shouldn't be already hovered after the mouse was clicked and none of the dots should be currently dragged.  
        active[lineNr] = true; //make line active; indicates that another control points should be added, the moment the mouse is released
        savePos[lineNr] = i; //saves the position of the line segment, to make sure the extra control point will be added at the right position later on
      }
      if (mousePressed && keyPressed && hoverStraightLine(allPoints[lineNr][i][0], allPoints[lineNr][i][1], allPoints[lineNr][i+1][0], allPoints[lineNr][i+1][1]) && !active[lineNr] && !dotsActive[lineNr]) { // checks whether mouse is pressed AND any key is pressed, and if the line is a straight line.
        curve[lineNr][i] = true; //turns this line in a curve
        stillPressed[lineNr] = true; //makes sure the program doesn't repeat this process untill the mouse is released.
        bezierPoints[lineNr][i][0][0] = (2*allPoints[lineNr][i][0]+allPoints[lineNr][i+1][0])/3;  //bezier control points are added.
        bezierPoints[lineNr][i][0][1] = (2*allPoints[lineNr][i][1]+allPoints[lineNr][i+1][1])/3;
        bezierPoints[lineNr][i][1][0] = (2*allPoints[lineNr][i+1][0]+allPoints[lineNr][i][0])/3;
        bezierPoints[lineNr][i][1][1] = (2*allPoints[lineNr][i+1][1]+allPoints[lineNr][i][1])/3;
      }


      if (mousePressed && keyPressed & bezierHover && !stillPressed[lineNr] && !active[lineNr] && !dotsActive[lineNr] && curve[lineNr][i]) { // checks if the mouse and any key are pressed, and if this line is a curve.
        curve[lineNr][i] = false; // changes the curve to a straight line. 
        stillPressed[lineNr] = true;
      }
    }
  }





  if (!mousePressed && stillPressed[lineNr]) {
    stillPressed[lineNr] = false;
  }
  if (active[lineNr] && !mousePressed && !dotsActive[lineNr]) { // if mouse = released: allocate mouseX and mouseY
    count[lineNr]++;  //add one control point
    if (savePos[lineNr] == 9999) {
      allPoints[lineNr][count[lineNr]][0] = mouseX;
      allPoints[lineNr][count[lineNr]][1] = mouseY;
    } else {
      for (int i = arrayLength - 1; i > savePos[lineNr]+1; i--) { // this part increases the position of each value with one, up to the position of the added control point.
        allPoints[lineNr][i][0] = allPoints[lineNr][i-1][0];
        allPoints[lineNr][i][1] = allPoints[lineNr][i-1][1];
        bezierPoints[lineNr][i][0][0] = bezierPoints[lineNr][i-1][0][0];
        bezierPoints[lineNr][i][0][1] = bezierPoints[lineNr][i-1][0][1];
        bezierPoints[lineNr][i][1][0] = bezierPoints[lineNr][i-1][1][0];
        bezierPoints[lineNr][i][1][1] = bezierPoints[lineNr][i-1][1][1];
        curve[lineNr][i] = curve[lineNr][i-1];
      }
      allPoints[lineNr][savePos[lineNr]+1][0] = mouseX; //give control points the coordinates of the mouse, upon release
      allPoints[lineNr][savePos[lineNr]+1][1] = mouseY;
    }
    active[lineNr] = false;
  }

}