import processing.pdf.*;
import nl.tue.id.oogway.*;

int XSIZE=int(3.6*297);
int YSIZE=int(3.6*210);

boolean annotate = true;

//sides and angles defining the shape
float AB = 100;
float AC = 65;
float angleBAC= 60;

Oogway o;
PFont font;

//latest A, B, C coordinates
float Ax, Ay, Bx, By, Cx, Cy;

////for tessellating the groups of the pieces
float hDistance, hHeading;
float vDistance, vHeading;

void setup() {
  size(XSIZE, YSIZE);
  o = new Oogway(this);
  noLoop(); 
  smooth();
  beginRecord(PDF, "CCC" + (annotate?"_Annotated.pdf":".pdf"));
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate) font = createFont("Comic Sans MS", 32);
}

void draw() {
  background(255);

  o.right(90);

  o.setPosition(600, 280);
  tesselate(1);

  o.setPosition(200, 330);
  drawPiece(3);

  if (annotate) drawPoints();
  if (annotate) drawIntro();

  endRecord();
}

void tesselate(float scale) {
  o.pushState();

  for (int i=0; i<3; i++) {
    o.pushState();
    for (int j=0; j<5; j++) {
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

  //Let AB be a C-line
  o.remember("A");
  Ax=o.xcor(); 
  Ay = o.ycor();
  o.shiftForward(AB*scale);
  Bx=o.xcor(); 
  By = o.ycor();
  cline(Ax, Ay, Bx, By, "AM1.svg");

  //Draw another C-line from A to C
  o.recall("A");
  o.left(angleBAC);
  o.shiftForward(AC*scale);
  Cx=o.xcor(); 
  Cy = o.ycor();
  cline(Ax, Ay, Cx, Cy, "AM3.svg");

  //Draw a third C-line from B to C
  cline(Bx, By, Cx, Cy, "BM2.svg");

  o.popState();

  if (annotate) drawArrow(scale);
}

void groupPositions(float scale) {
  o.pushState();

  drawPiece(scale);

  hHeading = o.towards(Cx, Cy);
  hDistance = o.distance(Cx, Cy);

  vHeading = o.towards(Bx, By);
  vDistance = o.distance(Bx, By);

  o.setPosition(Bx, By);
  o.left(180);
  drawPiece(scale);

  o.popState();
}



