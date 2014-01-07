import processing.pdf.*;
import nl.tue.id.oogway.*;

int XSIZE=int(3.6*297);
int YSIZE=int(3.6*210);

boolean annotate = true;

//sides and angles defining the shape
float AB = 100;
float AD = 125;

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
  beginRecord(PDF, "G1G2G1G2" + (annotate?"_Annotated.pdf":".pdf"));
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate)font = createFont("Comic Sans MS", 32);
}

void draw() {
  background(255);
  //if(annotate) showGrid();


  o.setPosition(650, 370);
  tesselate(0.5);

  o.setPosition(250, 600);
  drawPiece(1.5);

  if (annotate) drawPoints();
  if (annotate) drawAxes();
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

  //Let A, B, C and D be the points of a rectangle.
  //Glide-reflect the arbitrary line AB to CD.

  //AB
  o.remember("A");
  Ax = o.xcor(); 
  Ay = o.ycor();
  o.pathForward(AB*scale, "AB.svg"); 
  Bx = o.xcor(); 
  By = o.ycor();

  //DC
  o.recall("A");
  o.shiftLeft(90, AD*scale);
  Dx = o.xcor(); 
  Dy = o.ycor();
  o.shiftForward(AB*scale);
  Cx = o.xcor(); 
  Cy = o.ycor();
  o.beginReflection();
  o.pathBackward(AB*scale, "AB.svg");
  o.endReflection();


  //Glide-reflect another arbitrary line AD towards CB 

  //AD
  o.setPosition(Ax, Ay);
  o.setHeading(o.towards(Dx, Dy));
  o.pathForward(AD*scale, "AD.svg");

  //CB
  o.setPosition(Cx, Cy);
  o.setHeading(o.towards(Bx, By));
  o.beginReflection();
  o.pathForward(AD*scale, "AD.svg");
  o.endReflection();  

  o.popState();

  if (annotate) drawArrow(scale);
}


void groupPositions(float scale) {
  o.pushState();

  o.remember("O");
  drawPiece(scale);

  o.right(180);
  drawPiece(scale);

  o.recall("O");
  o.shiftForward(AB*scale);
  o.shiftRight(90, AD*scale);
  o.right(180);
  o.beginReflection();
  drawPiece(scale);
  o.endReflection();

  o.recall("O");
  o.right(180);
  o.shiftForward(AB*scale);
  o.shiftRight(90, AD*scale);
  o.right(180);
  o.beginReflection();
  drawPiece(scale);
  o.endReflection();

  o.recall("O");
  hHeading = o.heading();
  hDistance = AB*scale*2;
  
  o.right(90);
  vHeading = o.heading();
  vDistance = AD*scale*2;

  o.popState();
}

