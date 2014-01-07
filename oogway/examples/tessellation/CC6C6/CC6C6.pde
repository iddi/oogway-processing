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
float Ax, Ay, Bx, By, Cx, Cy;

////for tessellating the groups of the pieces
float hDistance, hHeading;
float vDistance, vHeading;

void setup() {
  size(XSIZE, YSIZE);
  o = new Oogway(this);
  noLoop(); 
  smooth();
  beginRecord(PDF, "CC6C6" + (annotate?"_Annotated.pdf":".pdf"));
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate)font = createFont("Comic Sans MS", 32);
}

void draw() {
  background(255);

  o.left(150);

  o.setPosition(600, 370);
  tesselate(0.8);

  o.setPosition(350, 500);
  drawPiece(2);

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

  // Turn the arbitrary line AB around A by 60 degrees into the position AC;

  //AB
  o.remember("A");
  Ax = o.xcor(); 
  Ay = o.ycor();
  o.pathForward(AB*scale, "AB.svg");
  Bx = o.xcor(); 
  By = o.ycor();

  //AC
  o.recall("A");
  o.left(60);
  o.pathForward(AB*scale, "AB.svg");
  Cx = o.xcor(); 
  Cy = o.ycor();

  // connect C to B by a C-line.

  cline(Bx, By, Cx, Cy, "BM.svg");

  o.popState();

  if (annotate) drawArrow(scale);
}

void groupPositions(float scale) {
  o.pushState();

  drawPiece(scale);

  o.right(60);
  drawPiece(scale);

  o.right(60);
  drawPiece(scale);

  o.right(60);
  drawPiece(scale);
  float _Mx = (Bx+Cx)/2, _My=(By+Cy)/2;
  hHeading = o.towards(_Mx, _My);
  hDistance = 2 * o.distance(_Mx, _My);

  o.right(60);
  drawPiece(scale);
  _Mx = (Bx+Cx)/2; 
  _My=(By+Cy)/2;
  vHeading = o.towards(_Mx, _My);
  vDistance = 2 * o.distance(_Mx, _My);

  o.right(60);
  drawPiece(scale);



  o.popState();
}

