//This is an editor, meant to produce any kind of CG1CG2G1G2 ground type, as defined by Heesch and Kienzle.
//The following controls apply:
//  -  Drag control points by clicking them and dragging them to the desired position.
//  -  Slide over a line segment with the mouse clicked to create a new control point in this line segment.
//  -  Turn any straight line segment in a curve and the other way around by sliding the mouse over it, with the mouse pressed and any key pushed.
//  -  Zoom in around the mouse by using the arrow keys (^ to zoom in, v to zoom out).
//  -  To see the shape in a pattern, press ENTER, this might take a while.
//  -  To save the current canvas, press SHIFT.

//Not every line segment and dot can be changed, generally the line on the top and left side of the shape are editable, but play around with this, or 
//find more elaborated documentation on https://1drv.ms/b/s!AsUjcAm5XkGNgeIo4XPPDTZyjExGkw

//Teun Keusters, 30-01-2017


import processing.pdf.*;

int arrayLength = 10; //maximum number of control points
float[][][] allPoints = new float[4][arrayLength][2]; // 4: each line one; arrayLength: number of possible control points in one line; 2: x,y
float[][][][] bezierPoints = new float [4][arrayLength][2][2]; //same structure as allPoints, but stores two x and y values, one for each bezier control point
boolean[][] curve = new boolean[4][arrayLength]; //true if a line segment should be a curve
int[] count = new int[4]; //number of active control points on one line

boolean[] active = new boolean[5]; // boolean to make sure an action is not performed twice within one mouseclick. On mouseclick this boolean becomes true. It will not become false untill the mouse is released.
boolean[] dotsActive = new boolean[4]; //same as active, but for dots
boolean[] stillPressed= new boolean[4]; //same purpose

boolean bezierHover;  // true if a beziercurve is hovered
int[] savePos= new int[4]; // used to temporary store the position in allPoints of a new dot. To keep the values of allPoints in the right order
float[] pointE = new float[2]; //last point of line 3.
float Xc;    // vertical glide reflection line
boolean showPattern = false; //if true the whole pattern will be showed, instead of just one shape.

int startHeight = 150;  
float zoomMag = 1.25; // magnification factor for zooming
boolean record = false; //if true: records shape/pattern

void setup() {
  fullScreen();
  background(255);
  //starting values of most control points, can be changed.
  allPoints[0][0][0] = width/2+startHeight/2;
  allPoints[0][0][1] = height/2+startHeight/4;
  allPoints[1][0][0] = width/2-startHeight/2;
  allPoints[1][0][1] = height/2-startHeight/4; 
  allPoints[2][0][0] = width/2-startHeight;
  allPoints[3][0][0] = width/2-startHeight/1.5;
  pointE[1] = height/2+startHeight*1.5;
}

void draw() {
  Xc = targetX(allPoints[0][0][0], allPoints[1][0][0])-(allPoints[3][0][0]-allPoints[2][0][0])/2;
  pointE[0] = 2*Xc - allPoints[0][0][0];
  allPoints[2][0][1] = allPoints[0][0][1];
  allPoints[3][0][1] = ((pointE[1]-allPoints[1][0][1])/2+allPoints[1][0][1] - allPoints[0][0][1])+(pointE[1]-allPoints[1][0][1])/2+allPoints[1][0][1];
  background(255);
  if (record) {
    beginRecord(PDF, "newCapture.pdf");
  }


  if (keyPressed && keyCode == UP && !active[4]) { //if arrow-up is pushed
    active[4] = true;
    resize(1); //zoom in
  } else if (keyPressed && keyCode == DOWN && !active[4]) { // if arrow-down is pushed
    active[4] = true;
    resize(-1); //zoom-out
  } else if (keyPressed && !active[4] && (key == ENTER || key == RETURN)) {//if enter key is pressed, show/hide pattern
    showPattern = !showPattern;
    active[4] = true;
  }
  if (!keyPressed && active[4]) {
    active[4] = false;
  }
  
  if (showPattern) {//if the pattern should be showed, repeat the pattern as defined in pattern() as much as needed to reach the borders of the screen.
    for (int j = -int(height/(2*(highestValues(1)-lowestValues(1)))); j < 2+height/(2*(highestValues(1)-lowestValues(1))); j++) {
      for (int i = -int(width/(2*(highestValues(0)-lowestValues(0)))); i < width/(2*(highestValues(0)-lowestValues(0))); i++) {
        pushMatrix();
        translate(i*2*(allPoints[0][0][0]-allPoints[3][0][0]), j*2*(pointE[1]-allPoints[0][0][1]));
        pattern();
        popMatrix();
      }
    }
  } else {
    shape(0);
  }
  if (record) {
    endRecord();
    exit();
  }
}



void keyPressed() {
  if (keyCode == SHIFT) {
    record = true;
  }
}