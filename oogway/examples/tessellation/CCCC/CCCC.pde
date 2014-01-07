import processing.pdf.*;
import nl.tue.id.oogway.*;

int XSIZE=int(3.6*297);
int YSIZE=int(3.6*210);

boolean annotate = true;

//sides and angles defining the shape
float AB = 100;
float BC = 160;
float CD = 90;
float angleABC = 80;
float angleBCD = 55;

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
  beginRecord(PDF, "CCCC" + (annotate?"_Annotated.pdf":".pdf"));
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate) font = createFont("Comic Sans MS", 32);
}

void draw() {
  background(255);

  o.setPosition(700, 300);
  o.left(170);
  tesselate(0.8);

  o.setPosition(400, 350);
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
    if (i%2==0)o.shift(180+hHeading, hDistance);
  }
  
  o.popState();

 if(annotate) highlightGroup(scale);
}

void drawPiece(float scale) {
  o.pushState();

  //Let AB and BC be two mutually independent C-lines with the common endpoint B.

  //AB
  Ax = o.xcor(); 
  Ay = o.ycor();
  o.shiftForward(AB*scale);
  Bx = o.xcor(); 
  By = o.ycor();
  cline(Ax, Ay, Bx, By, "AM1.svg");

  //BC
  o.left(180-angleABC);
  o.shiftForward(BC*scale);
  Cx = o.xcor(); 
  Cy = o.ycor();
  cline(Bx, By, Cx, Cy, "BM2.svg");

  //Draw from C an arbitrary third and from A another arbitrary fourth C-line 
  // towards the freely selected point D.

  //CD
  o.left(180-angleBCD);
  o.shiftForward(CD*scale);
  Dx = o.xcor(); 
  Dy = o.ycor();
  cline(Cx, Cy, Dx, Dy, "CM3.svg");

  //DA
  cline(Dx, Dy, Ax, Ay, "DM4.svg");

  o.popState();

  if (annotate) drawArrow(scale);
}

void groupPositions(float scale) {
  o.pushState();

  drawPiece(scale);
  float _Bx = Bx, _By = By;

  o.setPosition(Dx, Dy);
  o.left(180);
  drawPiece(scale);

  o.setPosition(Dx, Dy);
  vDistance = o.distance(Bx, By);
  vHeading = o.towards(Bx, By);

  o.setPosition(_Bx, _By);
  hDistance = o.distance(Cx, Cy);
  hHeading = o.towards(Cx, Cy);


  o.popState();
}


