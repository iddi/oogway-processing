import processing.pdf.*;
import nl.tue.id.oogway.*;

boolean annotate = true;

//sides and angles defining the shape
float AB = 100;
float AD = 125;
float AF = 85;
float BE = 100;
float angleFAB = 100;
float angleDAB = 77;
float angleABE = 125;

Oogway o;
PFont font;

//latest vertex coordinates
float Ax, Ay, Bx, By, Cx, Cy, Dx, Dy, Ex, Ey, Fx, Fy;

////for tessellating the groups of the pieces
float hDistance, hHeading;
float vDistance, vHeading;

void setup() {
  size(1069, 756); //int(3.6*297), int(3.6*210);
  o = new Oogway(this);
  noLoop(); 
  smooth();
  beginRecord(PDF, "TCCTCC" + (annotate?"_Annotated.pdf":".pdf"));
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate)font = createFont("Comic Sans MS", 32);
}

void draw() {
  background(255);

  o.left(15);

  o.setPosition(650, 350);
  tesselate(0.7);

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

  //Shift the arbitrary line AB to DC.

  //AB
  o.remember("A");
  Ax = o.xcor(); 
  Ay = o.ycor();
  o.pathForward(AB*scale, "AB.svg");
  o.remember("B");
  Bx = o.xcor(); 
  By = o.ycor();

  //DC
  o.recall("A");
  o.shiftLeft(angleDAB, AD*scale);
  Dx = o.xcor(); 
  Dy = o.ycor();
  o.pathForward(AB*scale, "AB.svg");
  Cx = o.xcor(); 
  Cy = o.ycor();

  // Draw from A a C-line to the arbitrary point F

  //AF
  o.recall("A");
  o.left(angleFAB);
  o.shiftForward(AF*scale);
  Fx = o.xcor(); 
  Fy = o.ycor();
  cline(Ax, Ay, Fx, Fy, "AM1.svg");

  //connect F by a second C-line to D.

  //FD
  cline(Fx, Fy, Dx, Dy, "FM2.svg");

  //Draw a third C-line from B to the freely chosen point E 

  //BE
  o.recall("B");
  o.left(180-angleABE);
  o.shiftForward(BE*scale);
  Ex = o.xcor(); 
  Ey = o.ycor();
  cline(Bx, By, Ex, Ey, "BM3.svg");


  //and close the figure by means of a fourth C-line CE.

  //EC
  cline(Ex, Ey, Cx, Cy, "EM4.svg");

  o.popState();

  if (annotate) drawArrow(scale);
}

void groupPositions(float scale) {
  o.pushState();

  o.left(180);
  drawPiece(scale);
  float _Bx = Bx, _By = By;

  o.setPosition(Fx, Fy);
  o.left(180);
  drawPiece(scale);

  vDistance = o.distance(Dx, Dy);
  vHeading = 180 + o.towards(Dx, Dy);

  o.setPosition(_Bx, _By);
  hDistance = o.distance(Ex, Ey);
  hHeading = o.towards(Ex, Ey);

  o.popState();
}