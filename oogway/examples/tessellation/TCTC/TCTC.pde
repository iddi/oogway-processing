import processing.pdf.*;
import nl.tue.id.oogway.*;

boolean annotate = true;

//sides and angles defining the shape
float AB = 100;
float BC = 125;
float angleDAB = 75;

Oogway o;
PFont font;

//latest vertex coordinates
float Ax, Ay, Bx, By, Cx, Cy, Dx, Dy;

////for tessellating the groups of the pieces
float hDistance, hHeading;
float vDistance, vHeading;

void setup() {
  size(1069, 756); //int(3.6*297), int(3.6*210);
  o = new Oogway(this);
  noLoop(); 
  smooth();
  beginRecord(PDF, "TCTC" + (annotate?"_Annotated.pdf":".pdf"));
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate) font = createFont("Comic Sans MS", 32);
}

void draw() {
  background(255);

  o.left(15);

  o.setPosition(650, 300);
  tesselate(0.8);

  o.setPosition(200, 650);
  drawPiece(2);

  if (annotate) drawPoints();
  if (annotate) drawIntro();

  endRecord();
}

void tesselate(float scale) {
  o.pushState();

  for (int i=0; i<4; i++) {
    o.pushState();
    for (int j=0; j<2; j++) {
      groupPositions(scale);
      o.shift(hHeading, hDistance);
    }
    o.popState();
    o.shift(vHeading, vDistance);
  }
  
  o.popState();

 if(annotate) highlightGroup(scale);
}

void drawPiece(float scale) {
  o.pushState();

  //Shift the arbitrary line AB to DC so that drawPiece are the corners of a parallelogram.

  //AB
  o.remember("A");
  Ax = o.xcor(); 
  Ay = o.ycor();
  o.pathForward(AB*scale, "AB.svg");
  Bx = o.xcor(); 
  By = o.ycor();

  //DC
  o.recall("A");
  o.shiftLeft(angleDAB, BC*scale);
  Dx = o.xcor(); 
  Dy = o.ycor();
  o.pathForward(AB*scale, "AB.svg");
  Cx = o.xcor(); 
  Cy = o.ycor();

  // Connect A to D using a C-line. Place a second (independent of the previous) 
  // C-line (same end point distances) from B to C.

  //AD
  cline(Ax, Ay, Dx, Dy, "AM1.svg");

  //BC
  cline(Bx, By, Cx, Cy, "BM2.svg");

  o.popState();

  if (annotate) drawArrow(scale);
}

void groupPositions(float scale) {
  o.pushState();

  o.left(180);
  drawPiece(scale);

  o.setPosition(Dx, Dy);
  o.left(180);
  drawPiece(scale);

  hDistance = 2*AB*scale;
  hHeading = o.heading();

  vDistance = BC*scale;
  vHeading = o.heading() + 180 - angleDAB;

  o.popState();
}