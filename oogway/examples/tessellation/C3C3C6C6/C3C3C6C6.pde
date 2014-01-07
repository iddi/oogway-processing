import processing.pdf.*;
import nl.tue.id.oogway.*;

int XSIZE=int(3.6*297);
int YSIZE=int(3.6*210);

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
  size(XSIZE, YSIZE);
  o = new Oogway(this);
  noLoop(); 
  smooth();
  beginRecord(PDF, "C3C3C6C6" + (annotate?"_Annotated.pdf":".pdf"));
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate)font = createFont("Comic Sans MS", 32);
}

void draw() {
  background(255);

  o.right(150);

  o.setPosition(600, 280);
  tesselate(0.4);

  o.setPosition(250, 350);
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
    if (i%2==0) o.shift(180+hHeading, hDistance);
  }
  
  o.popState();
  
  if(annotate) highlightGroup(scale);
}

void drawPiece(float scale) {
  o.pushState();

  // Turn the arbitrary line AB around A by 120 degrees into the position AC.

  //AB
  o.remember("A");
  Ax = o.xcor(); 
  Ay = o.ycor();
  o.pathForward(AB*scale, "AB.svg");
  Bx = o.xcor(); 
  By = o.ycor();

  //AC
  o.recall("A");
  o.left(120);
  o.pathForward(AB*scale, "AB.svg");
  Cx = o.xcor(); 
  Cy = o.ycor();

  // Let D together with C and B form an equilateral triangle, which does not contain A.

  //BD
  o.setPosition(Bx, By);
  o.setHeading(o.towards(Cx, Cy));
  o.right(60);
  o.pathForward(o.distance(Cx, Cy), "BD.svg");  
  Dx = o.xcor(); 
  Dy = o.ycor();

  //CD
  o.setPosition(Cx, Cy);
  o.setHeading(o.towards(Dx, Dy));
  o.pathForward(o.distance(Dx, Dy), "BD.svg");   

  o.popState();

  if (annotate) drawArrow(scale);
}


void groupPositions(float scale) {
  o.pushState();

  drawPiece(scale);

  o.mirrorPosition(Cx, Cy, Dx, Dy);
  o.right(60);  
  drawPiece(scale);

  o.pushState();
  o.setPosition(Dx, Dy);
  hHeading = o.towards(Cx, Cy);
  hDistance = 2 * o.distance(Cx, Cy);
  o.popState();

  o.mirrorPosition(Cx, Cy, Dx, Dy);
  o.right(60);  
  drawPiece(scale);

  o.pushState();
  o.setPosition(Dx, Dy);
  vHeading = o.towards(Cx, Cy);
  vDistance = 2 * o.distance(Cx, Cy);
  o.popState();  

  o.mirrorPosition(Cx, Cy, Dx, Dy);
  o.right(60);  
  drawPiece(scale);

  o.mirrorPosition(Cx, Cy, Dx, Dy);
  o.right(60);  
  drawPiece(scale);

  o.mirrorPosition(Cx, Cy, Dx, Dy);
  o.right(60);  
  drawPiece(scale);

  o.popState();
}

