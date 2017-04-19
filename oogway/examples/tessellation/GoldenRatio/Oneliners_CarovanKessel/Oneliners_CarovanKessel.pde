//Oneliners designed by Caro van Kessel 
//M1.1 student at the Industrial Design department of the TU/e
//Elective: Golden Ratio & Generative Arts 
//01 - 2017

import processing.pdf.*;
int N = 1; //version of PDF 
int M = 6; //version of PDF 
float[][][] myPoints = new float[600][5][2]; //5 points, 600 curves can be made
PImage img; 
int r = 4; //diameter points
int d = 30; //vertical distance of straight lines
int j = 4; //how many control points +1, because of the '<' sign
int up; //lines above the first curve
int down; //lines under the last curve 
int numClicks; //amount of clicks 
boolean image = true;
boolean clickPoints = true; //create new points on/off
boolean straightLines =false; //lines above and under the curves
boolean drawCurves = false; //draw the curve
boolean linesBeforeAfter = false; //Lines before the first anchor point and last anchor point 
boolean topLines = true;  //lines above the first curve 
boolean off; // Points visible on/off
int u;
int x;

void setup() {
  size(1500, 1000);
  stroke(19, 216, 136);
  strokeWeight(2);
  background(255); 
  img = loadImage("climbing1.jpg");
}

//curve with controlpoints
float polynomial(float x0, float x1, float x2, float x3, float x4, float t) {
  //sum of binomials (5 over 0,1,2,3,4) times polynomial in t 
  return x0  *   pow((1-t), j) 
    + x1 *4 * pow((1-t), 3) * t
    + x2 *6 * pow((1-t), 2) * pow(t, 2)
    + x3 *4 * pow((1-t), 1) * pow(t, 3)
    + x4 * pow(t, j);
}

//5 points: anchor, control, control, control, anchor
void myCurve(float[][][] p) {

  //draw the curve as connected line segments
  for (int o=0; o<600; o++) {

    float prev_x = p[o][0][0]; //x first point 
    float prev_y = p[o][0][1]; //y first point 

    for (int i=1; i < 200; i++) {

      float t = i * 0.005;
      float x = polynomial(p[o][0][0], p[o][1][0], p[o][2][0], p[o][3][0], p[o][4][0], t);
      float y = polynomial(p[o][0][1], p[o][1][1], p[o][2][1], p[o][3][1], p[o][4][1], t);
      stroke(19, 216, 136); 
      if (drawCurves == true) {
        line(prev_x, prev_y, x, y); //draw the curve
      }
      prev_x = x;
      prev_y = y;
    }
  }
}

void mouseClicked() {
  numClicks++;
  if (clickPoints == true) {
    if (numClicks < 1500) {
      if ( numClicks%2 != 0) {
        if (keyPressed) {
          if (keyCode == LEFT) {
            myPoints[x][0][0] = mouseX;
            myPoints[x][0][1] = myPoints[x-1][j][1]; //become same y-cor as the previous point -> get two curves on the same y-as
            x++;
          }
        } else {
          myPoints[x][0][0] = mouseX;
          myPoints[x][0][1] = mouseY;
          x++;
        }
      }
      if ( numClicks%2 == 0) {
        myPoints[u][4][0] = mouseX;
        myPoints[u][4][1] = myPoints[u][0][1];//become same y-cor as first point -> get the two points of one curve on the same y-as
        u++;
      }
    }
  }
}

void drawLines() {
  //Drawing 10 curves next to each other (especially when drawing letters)
  int c1, c2, c3, c4, c5, c6, c7, c8, c9;  

  for (int q =0; q<80; q++) {
    c1 = q+1;
    c2 = q+2;
    c3 = q+3;  
    c4 = q+4;
    c5 = q+5;
    c6 = q+6; 
    c7 = q+7;  
    c8 = q+8;
    c9 = q+9;
    int z = 1; 

    if (myPoints[q][0][1] == myPoints[c9][j][1]) {// if 10 curves are on the same y cordinate
      line(0, myPoints[q][0][1], myPoints[q][0][0], myPoints[q][0][1]);  //fixed lines before curves 
      for (int r = 0; r<9; r++) {
        line(myPoints[q+r][j][0], myPoints[q+r][j][1], myPoints[q+r+z][0][0], myPoints[q+r+z][0][1]); //fixed lines between curves
        line(myPoints[c9][j][0], myPoints[c9][j][1], 1500, myPoints[c9][j][1]);  //fixed lines after curves
      } 
      q+=9;//skip the next 9 curves since they are at the same y cordinate
    } else if (myPoints[q][0][1] == myPoints[c8][j][1]) {// if 9 curves are on the same y cordinate
      line(0, myPoints[q][0][1], myPoints[q][0][0], myPoints[q][0][1]); 
      for (int r = 0; r<8; r++) { 
        line(myPoints[q+r][j][0], myPoints[q+r][j][1], myPoints[q+r+z][0][0], myPoints[q+r+z][0][1]); 
        line(myPoints[c8][j][0], myPoints[c8][j][1], 1500, myPoints[c8][j][1]);
      } 
      q+=8;
    } else if (myPoints[q][0][1] == myPoints[c7][j][1]) {// if 8 curves are on the same y cordinate
      line(0, myPoints[q][0][1], myPoints[q][0][0], myPoints[q][0][1]);  
      for (int r = 0; r<7; r++) {
        line(myPoints[q+r][j][0], myPoints[q+r][j][1], myPoints[q+r+z][0][0], myPoints[q+r+z][0][1]); 
        line(myPoints[c7][j][0], myPoints[c7][j][1], 1500, myPoints[c7][j][1]);
      } 
      q+=7;
    } else if (myPoints[q][0][1] == myPoints[6][j][1]) {// if 7 curves are on the same y cordinate
      line(0, myPoints[q][0][1], myPoints[q][0][0], myPoints[q][0][1]);   
      for (int r = 0; r<6; r++) {
        line(myPoints[q+r][j][0], myPoints[q+r][j][1], myPoints[q+r+z][0][0], myPoints[q+r+z][0][1]); 
        line(myPoints[c6][j][0], myPoints[c6][j][1], 1500, myPoints[c6][j][1]);
      } 
      q+=6;
    } else if (myPoints[q][0][1] == myPoints[c5][j][1]) {// if 6 curves are on the same y cordinate
      line(0, myPoints[q][0][1], myPoints[q][0][0], myPoints[q][0][1]); 
      for (int r = 0; r<5; r++) {
        line(myPoints[q+r][j][0], myPoints[q+r][j][1], myPoints[q+r+z][0][0], myPoints[q+r+z][0][1]);
      } 
      q+=5;
    } else if (myPoints[q][0][1] == myPoints[c4][j][1]) {// if 5 curves are on the same y cordinate
      line(0, myPoints[q][0][1], myPoints[q][0][0], myPoints[q][0][1]);  
      for (int r = 0; r<4; r++) {
        line(myPoints[q+r][j][0], myPoints[q+r][j][1], myPoints[q+r+z][0][0], myPoints[q+r+z][0][1]);
        line(myPoints[c4][j][0], myPoints[c4][j][1], 1500, myPoints[c4][j][1]);
      } 
      q+=4;
    } else if (myPoints[q][0][1] == myPoints[c3][j][1]) {// if 4 curves are on the same y cordinate
      line(0, myPoints[q][0][1], myPoints[q][0][0], myPoints[q][0][1]);  
      for (int r = 0; r<3; r++) {
        line(myPoints[q+r][j][0], myPoints[q+r][j][1], myPoints[q+r+z][0][0], myPoints[q+r+z][0][1]); 
        line(myPoints[c3][j][0], myPoints[c3][j][1], 1500, myPoints[c3][j][1]);
      } 
      q+=3;
    } else if (myPoints[q][0][1] == myPoints[c2][j][1]) {// if 3 curves are on the same y cordinate
      line(0, myPoints[q][0][1], myPoints[q][0][0], myPoints[q][0][1]);  
      for (int r = 0; r<2; r++) {
        line(myPoints[q+r][j][0], myPoints[q+r][j][1], myPoints[q+r+z][0][0], myPoints[q+r+z][0][1]); 
        line(myPoints[c2][j][0], myPoints[c2][j][1], 1500, myPoints[c2][j][1]);
      } 
      q+=2;
    } else if (myPoints[q][0][1] == myPoints[c1][j][1]) {// if 2 curves are on the same y cordinate
      line(0, myPoints[q][0][1], myPoints[q][0][0], myPoints[q][0][1]);  
      for (int r = 0; r<1; r++) {
        line(myPoints[q+r][j][0], myPoints[q+r][j][1], myPoints[q+r+z][0][0], myPoints[q+r+z][0][1]); 
        line(myPoints[c1][j][0], myPoints[c1][j][1], 1500, myPoints[c1][j][1]);
      } 
      q+=1;
    } else if (myPoints[q][0][1] != myPoints[c9][j][1]) { //if only 1 curve is on that y cordinate
      line(0, myPoints[q][0][1], myPoints[q][0][0], myPoints[q][0][1]); 
      line(myPoints[q][j][0], myPoints[q][j][1], 1500, myPoints[q][j][1]);
    }
  }
}

void draw() {
  background(255); 
  stroke(255, 0, 0);
  frameRate(200);

  if (image ==true) {//show image when boolean ==true
    image(img, 000, 000, 1500, 1000);
  }

  //draw the points of myPoints 
  for (int o=0; o<100; o++) {
    for (int k=0; k<5; k++) {
      if (off == false) {
        ellipse(myPoints[o][k][0], myPoints[o][k][1], r, r); // draw the circles of the points with r as diameter 
      }
      if (mousePressed) {
        for (int p=1; p < 4; p++) {
          //drag the point being near the mouse
          //keep them at least 14 pixels apart
          if (dist(myPoints[o][p][0], myPoints[o][p][1], mouseX, mouseY) < 20) {
            myPoints[o][p][0] = mouseX;
            myPoints[o][p][1] = mouseY;
          }
        }
      }
    }
  }
  myCurve(myPoints); //draw the curve using my points 

  if (linesBeforeAfter == true) { 
    drawLines(); // draw line next to the curves
  }

  if (straightLines == true) {
    for (int l = 0; l<(myPoints[0][0][1]-up); l= l+d) { // draw lines from top to first curve, y direction DOWN
      line(0, l, 1500, l);
    }
    for (int b = 1500; b>myPoints[u-1][0][1]+down; b= b-d) { //draw lines from bottom to last curve, y direction UP
      line(0, b, 1500, b);
    }
  }
}

void keyPressed() {
  if (keyCode == ENTER) {//show image on/off
    if (image == true) {
      image = false;
    } else {
      image = true;
    }
  }

  if (key == 'c') { //Set controlpoints on/off 
    if (r ==4) {
      off = true; 
      r = 0;
    } else {
      off = false; 
      r =4;
    }
  }
  if (key == 'l') { //Set lines above and under the curves On/Off
    if (straightLines == true) {
      straightLines = false;
    } else {
      straightLines = true;
    }
  }
  if (key == 'k') { //mouseClick = create points or mouseClick = move controlpoints of beziercurve 
    if (clickPoints == true) {
      clickPoints = false;
    } else {
      clickPoints = true;
    }
  }
  if (key == 'd') {//when finished with creating the anchor points, draw bezier curve
    if (drawCurves == false) {
      drawCurves = true;
    } else {
      drawCurves = false;
    }

    if (linesBeforeAfter == false) {
      linesBeforeAfter = true;
    } else {
      linesBeforeAfter = false;
    }

    for (int o=0; o<100; o++) { //20 lines 
      for (int k=0; k<j; k++) { // 9 control points 
        for (int i=0; i<2; i++) {  //x,y (0,1)   
          if (k != 0 || k != j) {
            if (i == 0) {
              myPoints[o][k][i] = myPoints[o][0][0] + ((dist(myPoints[o][0][0], myPoints[o][0][1], myPoints[o][j][0], myPoints[o][j][1])/j) *k); // draw points with 50px in between
            }
            if (i == 1) {
              myPoints[o][k][i] = myPoints[o][0][1]; //draw line below
            }
          }
        }
      }
    }
  }
  if (keyCode == ESC) {//export the final creation to a PDF file and close the program
    beginRecord(PDF, "LineArt_" + str(N) + str(M) +  ".pdf");
    draw(); 
    endRecord();
    exit();
  }

  //Adjust the distance in y direction of the straight lines 
  if (key == '=') {
    d = d + 1;
  }
  if (key == '-') {
    d= d - 1;
  } else if (keyCode == TAB) { //switch between adjusting the lines above the first curve or lines beneath the last curve
    if (topLines == true) {
      topLines = false;
    } else {
      topLines = true;
    }
  }
 
  if (topLines == true) {
    if (keyCode == UP) {
      up = up + 10;//add more distance on top between the straightLines and first curve
    }
    if (keyCode == DOWN) {
      up = up - 10;//remove distance on top between the straightLines and first curve
    }
  } else {
    if (keyCode == UP) {
      down = down + 10;//add more distance at the bottom between the straightLines and last curve
    }
    if (keyCode == DOWN) {
      down = down - 10;//remove distance at the bottom between the straightLines and last curve
    }
  }
}