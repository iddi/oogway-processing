import processing.pdf.*;
import nl.tue.id.oogway.*;

int XSIZE=int(3.6*297);
int YSIZE=int(3.6*210);

boolean annotate = true;

//sides and angles defining the shape
float AB = 100;
float AD = 125;
float AF = 85;
float angleBAD = 75;
float angleABE = 137;
float angleBAF = 98;

Oogway o;
PFont font;

//latest vertex coordinates
float Ax, Ay, Bx, By, Cx, Cy, Dx, Dy, Ex, Ey, Fx, Fy;


////for tessellating the groups of the pieces
float hDistance, hHeading;
float vDistance, vHeading;

void setup() {
  size(XSIZE, YSIZE);
  o = new Oogway(this);
  noLoop(); 
  smooth();
  beginRecord(PDF, "TCCTGG" + (annotate?"_Annotated.pdf":".pdf"));
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate)font = createFont("Comic Sans MS", 32);
}

void draw() {
  background(255);
  // if(annotate) showGrid();

  o.left(15);

  o.setPosition(550, 420);
  tesselate(0.4);

  o.setPosition(200, 600);
  drawPiece(1.5);

  if (annotate) drawPoints();
  if (annotate) drawAxes();
  if (annotate) drawIntro();

  endRecord();
}

void tesselate(float scale) {
  o.pushState();

  for (int i=0; i<6; i++) {
    o.pushState();
    for (int j=0; j<2; j++) {
      groupPositions(scale);
      o.shift(hHeading, hDistance);
    }
    o.popState();
    o.shift(vHeading, vDistance);
  }

  if (annotate) highlightGroup(scale);

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

  //Connect A as well as D to the arbitrary point F by one C-line each.

  //AF
  o.recall("A");
  o.left(angleBAF);
  o.shiftForward(AF*scale);
  Fx = o.xcor();
  Fy = o.ycor();
  cline(Ax, Ay, Fx, Fy, "AM1.svg");
  
  //DF
  cline(Dx, Dy, Fx, Fy, "AM1.svg");  

  //Then draw from B towards a point E on the perpendicular bisector NE of BC an arbitrary line BE 
  //and glide-reflect it into the position EC, making sure that it connects "

  //BE
  float BE = (AD/2) / cos(radians(angleABE-(180-angleBAD)));
  o.recall("B");
  o.left(180-angleABE);
  o.pathForward(BE*scale, "BE.svg");
  Ex = o.xcor(); 
  Ey = o.ycor();

  //EC
  o.setHeading(o.towards(Cx, Cy));
  o.beginReflection();
  o.pathForward(o.distance(Cx, Cy), "BE.svg");
  o.endReflection();

  o.popState();

  if (annotate) drawArrow(scale);
}


void groupPositions(float scale) {
  o.pushState();

  drawPiece(scale);
  float _Cx = Cx, _Cy = Cy;
  float _Ex = Ex, _Ey = Ey;

  vHeading = 180 + o.towards(Dx, Dy);
  vDistance = o.distance(Dx, Dy);

  o.setPosition(Fx, Fy);
  o.left(180);
  drawPiece(scale);
  float _Bx = Bx, _By = By;

  o.setPosition(_Ex, _Ey);
  o.setHeading(o.towards(_Cx, _Cy));
  o.right(angleABE);
  o.shiftForward(AB*scale); 
  o.right(180);
  o.beginReflection(); 
  drawPiece(scale);

  o.setPosition(Fx, Fy);
  o.left(180);
  drawPiece(scale);
  o.endReflection();

  o.setPosition(_Bx, _By);
  hHeading = o.towards(Ex, Ey);
  hDistance = o.distance(Ex, Ey);

  o.popState();
}

