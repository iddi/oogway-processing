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
  beginRecord(PDF, "CC3C3" + (annotate?"_Annotated.pdf":".pdf"));
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate)font = createFont("Comic Sans MS", 32);
}

void draw() {
  background(255);

  o.left(120);

  o.setPosition(600, 370);
  tesselate(0.6);

  o.setPosition(300, 500);
  drawPiece(1.5);

  if (annotate) drawPoints();
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
    if (i%2==0) o.shift(hHeading, hDistance);
  }
  
  o.popState();

 if(annotate) highlightGroup(scale);
}

void drawPiece(float scale) {
  o.pushState();

  //Turn the arbitrary line AB around A by 120 degrees into the position AC.

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

  // TConnect B to the midpoint M of the segment BC by an arbitrary line
  // and turn it around M by 180 into MC (by which BC becomes a C-line

  cline(Bx, By, Cx, Cy, "BM.svg");

  o.popState();

  if (annotate) drawArrow(scale);
}

void groupPositions(float scale) {
  o.pushState();

  drawPiece(scale);
  float _Mx = (Bx+Cx)/2, _My = (By+Cy)/2;

  o.right(120);
  drawPiece(scale);
  float _Bx=Bx, _By = By;

  o.right(120);
  drawPiece(scale);

  o.setHeading(o.towards(_Mx, _My));
  o.shiftForward(2*o.distance(_Mx, _My));

  drawPiece(scale);
  float _Mx_ = (Bx+Cx)/2, _My_ = (By+Cy)/2;   

  o.right(120);
  drawPiece(scale);
  float _Cx_ = Cx, _Cy_ = Cy;

  o.right(120);
  drawPiece(scale);

  o.setPosition(_Cx_, _Cy_);
  hHeading = o.towards(_Bx, _By);
  hDistance = o.distance(_Bx, _By);

  o.setPosition(_Mx, _My);
  vHeading = o.towards(_Mx_, _My_);
  vDistance = 2 * o.distance(_Mx_, _My_); 

  o.popState();
}

