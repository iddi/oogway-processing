import processing.pdf.*;
import nl.tue.id.oogway.*;

boolean annotate = true;

//sides and angles defining the shape
float AB = 100;
float AF = 95;
float AD = 125;
float angleBAD = 75;
float angleBAF = 90;

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
  beginRecord(PDF, "TTTTTT" + (annotate?"_Annotated.pdf":".pdf"));
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate) font = createFont("Comic Sans MS", 32);
}

void draw() {
  background(255);
  //showGrid();

  o.left(15); 

  o.setPosition(600, 500);
  tesselate(0.8);

  o.setPosition(200, 600);
  drawPiece(1.5);

  if (annotate) drawPoints();
  if (annotate) drawIntro();

  endRecord();
}

void tesselate(float scale) {
  o.pushState();

  for (int i=0; i<3; i++) {
    o.pushState();
    for (int j=0; j<3; j++) {
      groupPositions(scale);
      o.shift(hHeading, hDistance);
    }
    o.popState();
    o.shift(vHeading, vDistance);
  }

  o.popState();

  if (annotate) highlightGroup(scale);
}

void drawPiece(float scale) {
  o.pushState();

  //arbitrary line AB
  o.remember("A");
  Ax = o.xcor(); 
  Ay = o.ycor();
  o.pathForward(AB*scale, "AB.svg");
  Bx = o.xcor(); 
  By = o.ycor();

  //shift AB to DC
  o.recall("A");
  o.shiftLeft(angleBAD, AD*scale);
  Dx = o.xcor(); 
  Dy = o.ycor();
  o.pathForward(AB*scale, "AB.svg");
  Cx = o.xcor(); 
  Cy = o.ycor();

  //arbitrary line AF
  o.recall("A");
  o.left(angleBAF);
  o.pathForward(AF*scale, "AF.svg");
  Fx = o.xcor(); 
  Fy = o.ycor();

  //Shift AF to EC (Translation vector AE)
  float degreeFC = o.towards(Cx, Cy);
  float distanceFC = o.distance(Cx, Cy);
  o.recall("A");
  o.shift(degreeFC, distanceFC);
  Ex = o.xcor(); 
  Ey = o.ycor();
  o.setHeading(o.towards(Cx, Cy));
  o.pathForward(o.distance(Cx, Cy), "AF.svg");  

  //draw BE
  o.setPosition(Bx, By);
  o.setHeading(o.towards(Ex, Ey));
  o.pathForward(o.distance(Ex, Ey), "BE.svg"); 


  //Move BE to FD (translation vector BF)
  o.setPosition(Fx, Fy);
  o.setHeading(o.towards(Dx, Dy));
  o.pathForward(o.distance(Dx, Dy), "BE.svg"); 

  o.popState();

  if (annotate) drawArrow(scale);
}

void groupPositions(float scale) {
  o.pushState();

  drawPiece(scale);

  hHeading = o.towards(Ex, Ey);
  hDistance = o.distance(Ex, Ey);

  vHeading = 180+o.towards(Dx, Dy);
  vDistance = o.distance(Dx, Dy);

  o.popState();
}