import processing.pdf.*;
import nl.tue.id.oogway.*;

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
  size(1069, 756); //int(3.6*297), int(3.6*210);
  o = new Oogway(this);
  noLoop(); 
  smooth();
  beginRecord(PDF, "CGCG" + (annotate?"_Annotated.pdf":".pdf"));
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate)font = createFont("Comic Sans MS", 32);
}

void draw() {
  background(255);
  //if(annotate) showGrid();

  o.left(15);

  o.setPosition(600, 400);
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

 if(annotate) highlightGroup(scale);
}

void drawPiece(float scale) {
  o.pushState();

  //Glide-reflect the arbitrary line AB into the position DC 
  //(glide-reflection axis HI has the same distance from A and C, 
  //another equal distance from B and D).

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
  o.right(2*(90-angleBAD));
  o.shiftForward(AB*scale); 
  Cx = o.xcor(); 
  Cy = o.ycor();
  o.beginReflection();
  o.pathBackward(AB*scale, "AB.svg");
  o.endReflection();

  //Connect A to D by a C-line,

  //AD
  cline(Ax, Ay, Dx, Dy, "AM1.svg");

  //and also connect B to C by yet another C-line.
  
  //BC
  cline(Bx, By, Cx, Cy, "BM2.svg");

  o.popState();

  if (annotate) drawArrow(scale);
}


void groupPositions(float scale) {
  o.pushState();

  o.remember("O");
  drawPiece(scale);
  float _Dx = Dx, _Dy = Dy;
  float _M1x = (Ax+Dx)/2, _M1y = (Ay+Dy)/2;
  float _M2x = (Bx+Cx)/2, _M2y = (By+Cy)/2;

  o.setPosition(Bx, By);
  o.setHeading(o.towards(Ax, Ay));
  o.left(angleBAD);
  o.shiftForward(AD*scale);
  o.right(180-angleBAD);
  o.beginReflection();
  drawPiece(scale);
  o.endReflection();
  
  o.recall("O");
  o.setPosition(_Dx, _Dy);
  o.left(180);
  drawPiece(scale);
 
  o.setPosition(Cx, Cy);
  o.setHeading(o.towards(Dx, Dy));
  o.beginReflection();
  drawPiece(scale);
  o.endReflection();
  
  float M2x = (Bx+Cx)/2, M2y = (By+Cy)/2;
  
  o.setPosition(_M1x, _M1y);
  hHeading = o.towards(_M2x, _M2y);
  hDistance = 2 * o.distance(_M2x, _M2y);

  vHeading = o.towards(M2x, M2y);
  vDistance = 2 * o.distance(M2x, M2y);  

  o.popState();
}