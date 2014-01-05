import processing.pdf.*;
import nl.tue.id.oogway.*;

int XSIZE=int(3.6*297);
int YSIZE=int(3.6*210);

boolean annotate = true;

//sides and angles defining the shape
float AB = 100;
float AD = 125;
float angleBAD = 75;

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
  beginRecord(PDF, "TGTG" + (annotate?"_Annotated.pdf":".pdf"));
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate)font = createFont("Comic Sans MS", 32);
}

void draw() {
  background(255);
  //if(annotate) showGrid();

  o.left(15);

  o.setPosition(550, 400);
  tesselate(0.6);

  o.setPosition(250, 600);
  drawPiece(1.5);

  if (annotate) drawPoints();
  if (annotate) drawAxes();
  if (annotate) drawIntro();

  endRecord();
}

void tesselate(float scale) {
  o.pushState();

  for (int i=0; i<4; i++) {
    o.pushState();
    for (int j=0; j<3; j++) {
      groupPositions(scale);
      o.shift(hHeading, hDistance);
    }
    o.popState();
    o.shift(vHeading, vDistance);
  }
  
  if(annotate) highlightGroup(scale);

  o.popState();
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
  o.shiftLeft(angleBAD, AD*scale);
  Dx = o.xcor(); 
  Dy = o.ycor();
  o.pathForward(AB*scale, "AB.svg"); 
  Cx = o.xcor(); 
  Cy = o.ycor();

  //Then draw the arbitrary line AD and glide-reflect it into CB

  //AD
  o.recall("A");
  o.left(angleBAD);
  o.pathForward(AD*scale, "AD.svg");

  //CB
  o.setPosition(Cx, Cy);
  o.setHeading(o.towards(Bx, By));
  o.beginReflection();
  o.pathForward(o.distance(Bx, By), "AD.svg");
  o.endReflection();

  o.popState();

  if (annotate) drawArrow(scale);
}


void groupPositions(float scale) {
  o.pushState();

  drawPiece(scale);
  float _Ax = Ax, _Ay = Ay;

  vHeading = 180 + o.towards(Dx, Dy);
  vDistance = o.distance(Dx, Dy);

  o.setPosition(Cx, Cy);
  o.setHeading(o.towards(Bx, By));
  o.left(angleBAD);
  o.beginReflection(); 
  drawPiece(scale);
  o.endReflection();

  o.setPosition(_Ax, _Ay);
  hHeading = o.towards(Cx, Cy);
  hDistance = o.distance(Cx, Cy);

  o.popState();
}

