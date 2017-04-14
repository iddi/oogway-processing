void pattern() {
  for (int i = 0; i < 7; i++) { //this part applies every available symmetry and creates the basic shape with all six symmetries around it.
    pushMatrix();
    if (i==1) {
      translate(targetX(allPoints[1][0][0], allPoints[2][0][0]), targetY(allPoints[1][0][1], allPoints[2][0][1]));
      rotate(PI);
      translate(-targetX(allPoints[1][0][0], allPoints[2][0][0]), -targetY(allPoints[1][0][1], allPoints[2][0][1]));
    } else if (i == 2) {
      translate(0, targetY(allPoints[2][0][1], allPoints[3][0][1]));
      scale(1, -1);
      translate(allPoints[3][0][0]-allPoints[0][0][0], -targetY(allPoints[2][0][1], allPoints[3][0][1]));
    } else if (i == 3) {
      translate(targetX(allPoints[3][0][0], pointE[0]), targetY(allPoints[3][0][1], pointE[1]));
      rotate(PI);
      translate(-targetX(allPoints[3][0][0], pointE[0]), -targetY(allPoints[3][0][1], pointE[1]));
    } else if (i == 4) {
      translate(Xc, 0);
      scale(-1, 1);
      translate(-Xc, allPoints[3][0][1]-allPoints[1][0][1]);
    } else if (i == 5) {
      translate(0, targetY(allPoints[2][0][1], allPoints[3][0][1]));
      scale(1, -1);
      translate(allPoints[0][0][0]-allPoints[3][0][0], -targetY(allPoints[2][0][1], allPoints[3][0][1]));
    } else if ( i == 6) {
      translate(Xc, 0);
      scale(-1, 1);
      translate(-Xc, allPoints[1][0][1]-allPoints[3][0][1]);
    }
    shape(1);
    popMatrix();
  }
  delay(200);
}

void shape(int i) {
  newLine(0, i); //line 0
  //line(Xc, 0, Xc, height); // vertical glide reflection line
  pushMatrix(); //glide reflection of line 0
  translate(Xc*2, pointE[1]-allPoints[0][0][1]);
  scale(-1, 1);
  newLine(0, i); // draw glide reflected version of line 0
  popMatrix();



  newLine(1, i); //line 1
  pushMatrix(); // rotate the canvas around targetX and targetY of line 1
  translate(targetX(allPoints[1][0][0], allPoints[2][0][0]), targetY(allPoints[1][0][1], allPoints[2][0][1]));
  rotate(PI);
  translate(-targetX(allPoints[1][0][0], allPoints[2][0][0]), -targetY(allPoints[1][0][1], allPoints[2][0][1]));
  newLine(1, i); //draw rotated version of line 1
  popMatrix();


  newLine(2, i); //line 2 
  pushMatrix(); //glide reflection of line 2
  //line(0, targetY(allPoints[2][0][1], allPoints[3][0][1]), width, targetY(allPoints[2][0][1], allPoints[3][0][1])); // horizontal glide reflection line
  translate(allPoints[0][0][0] - allPoints[3][0][0], targetY(allPoints[2][0][1], allPoints[3][0][1])*2);
  scale(1, -1);
  newLine(2, i); // draw glide reflected version of line 0
  popMatrix();

  newLine(3, i); //line 3
  pushMatrix(); // rotate the canvas around targetX and targetY of line 3
  translate(targetX(allPoints[3][0][0], pointE[0]), targetY(allPoints[3][0][1], pointE[1]));
  rotate(PI);
  translate(-targetX(allPoints[3][0][0], pointE[0]), -targetY(allPoints[3][0][1], pointE[1]));
  newLine(3, i); //draw rotated version of line 3
  popMatrix();


  if (i == 0) { //draw rotation points if i = 0. i will be zero as long as a single shape is edited. If the pattern is shown i != 0
    fill(255, 0, 0);
    stroke(255, 0, 0);
    ellipse(targetX(allPoints[1][0][0], allPoints[2][0][0]), targetY(allPoints[1][0][1], allPoints[2][0][1]), 5, 5);
    ellipse(targetX(allPoints[3][0][0], pointE[0]), targetY(allPoints[3][0][1], pointE[1]), 5, 5);
    fill(255);
  }
  stroke(0);
}