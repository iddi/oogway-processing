import processing.pdf.*;
import nl.tue.id.oogway.*;

boolean annotate = true;

//sides and angles defining the shape
float AB = 100;

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
  beginRecord(PDF, "C3C3C3C3" + (annotate?"_Annotated.pdf":".pdf"));
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate)font = createFont("Comic Sans MS", 32);
}

void draw() {
  background(255);

  o.right(120);

  o.setPosition(400, 500);
  drawPiece(2);

  if (annotate) drawPoints();
  if (annotate) drawIntro();
  
  o.setPosition(650, 400);
  tesselate(0.7);

  endRecord();
}

void tesselate(float scale) {
  o.pushState();

  for (int i=0; i<3; i++) {
    o.pushState();
    for (int j=0; j<3; j++) {
      groupPositions(scale);
      o.shift(hHeading, hDistance);
      if (j%2==0)o.shift(180+vHeading, vDistance);
    }

    o.popState();
    o.shift(vHeading, vDistance);
  }
      
  o.popState();

  if(annotate) highlightGroup(scale);
}

void drawPiece(float scale) {
  o.pushState();

  //Turn the arbitrary line AB around A over 120 degrees into the position AC.

  //AB
  o.remember("A");
  Ax = o.xcor(); 
  Ay = o.ycor();
  o.pathForward(AB*scale, "AB.svg");
  Bx = o.xcor(); 
  By = o.ycor();

  //AC
  o.recall("A");
  o.right(120);
  o.pathForward(AB*scale, "AB.svg");
  Cx = o.xcor(); 
  Cy = o.ycor();

  // Let D be the refection-point of A with respect to the line through B and C.
  o.recall("A");
  o.mirrorPosition(Bx, By, Cx, Cy);
  Dx = o.xcor(); 
  Dy = o.ycor();

  //Connect D to B by an arbitrary line and turn it around D by 120 degrees into the position DC.

  //DB
  o.setHeading(o.towards(Bx, By));
  o.pathForward(o.distance(Bx, By), "DB.svg");  

  //DC
  o.setPosition(Dx, Dy);
  o.setHeading(o.towards(Cx, Cy));
  o.pathForward(o.distance(Cx, Cy), "DB.svg");   

  o.popState();

  if (annotate) drawArrow(scale);
}


void groupPositions(float scale) {
  o.pushState();

  drawPiece(scale);

  o.pushState();
  o.setPosition(Cx, Cy);
  vHeading = o.towards(Bx, By);
  vDistance = o.distance(Bx, By);
  o.popState();

  o.mirrorPosition(Dx, Dy, Bx, By);
  o.right(120);  
  drawPiece(scale);

  o.pushState();
  o.setPosition(Bx, By);
  hHeading = o.towards(Cx, Cy);
  hDistance = o.distance(Cx, Cy);
  o.popState();

  o.mirrorPosition(Dx, Dy, Bx, By);
  o.right(120);
  drawPiece(scale);

  o.popState();
}