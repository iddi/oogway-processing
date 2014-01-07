import processing.pdf.*;
import nl.tue.id.oogway.*;

int XSIZE=int(3.6*297);
int YSIZE=int(3.6*210);

boolean annotate = true;

//sides and angles defining the shape
float AB = 100;
float AD = 108;
float angleABC = 90;
float angleBAD = 70;

Oogway o;
PFont font;

//latest vertex coordinates
float Ax, Ay, Bx, By, Cx, Cy, Dx, Dy;


//for tessellating the groups of the pieces
float hDistance, hHeading;
float vDistance, vHeading;

void setup() {
  size(XSIZE, YSIZE);
  o = new Oogway(this);
  noLoop(); 
  smooth();
  beginRecord(PDF, "CCGG" + (annotate?"_Annotated.pdf":".pdf"));
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate)font = createFont("Comic Sans MS", 32);
}

void draw() {
  background(255);
  //if(annotate) showGrid();

  o.left(45);

  o.setPosition(550, 400);
  tesselate(0.8);

  o.setPosition(250, 600);
  drawPiece(2);

  if (annotate) drawPoints();
  if (annotate) drawAxes();
  if (annotate) drawIntro();

  endRecord();
}

void tesselate(float scale) {
  o.pushState();

  for (int i=0; i<3; i++) {
    o.pushState();
    for (int j=0; j<2; j++) {
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

  //Move the arbitrary line AB by glide-reflection to the position BC so that it connects 
  //(glide-reflection axis HI parallel to AC at the same distance from A as from B). 

  //AB
  o.remember("A");
  Ax = o.xcor(); 
  Ay = o.ycor();
  o.pathForward(AB*scale, "AB.svg"); 
  Bx = o.xcor(); 
  By = o.ycor();

  //DC
  o.left(180-angleABC);
  o.beginReflection();
  o.pathForward(AB*scale, "AB.svg"); 
  o.endReflection();
  Cx = o.xcor(); 
  Cy = o.ycor();

  //Draw both C-lines AD and CD towards an arbitrary point D
  
  //AD
  o.recall("A");
  o.left(angleBAD);
  o.shiftForward(AD*scale);
  Dx = o.xcor();
  Dy = o.ycor();
  cline(Ax, Ay, Dx, Dy, "AM1.svg");
  
  //CD
  cline(Cx, Cy, Dx, Dy, "CM2.svg");

  o.popState();

  if (annotate) drawArrow(scale);
}


void groupPositions(float scale) {
  o.pushState();

  drawPiece(scale);
  float _Ax = Ax, _Ay = Ay;
  float _Bx = Bx, _By = By; 
  
  vHeading = 180 + o.towards(Cx, Cy);
  vDistance = o.distance(Cx, Cy);
  
  o.setPosition(Dx, Dy);
  o.left(180);
  drawPiece(scale);
  float _Cx = Cx, _Cy = Cy;
  
  o.setPosition(_Ax, _Ay);
  o.setHeading(o.towards(_Bx, _By));
  o.right(angleABC);
  o.shiftForward(AB*scale);
  o.setHeading(o.towards(_Ax, _Ay));
  
  o.beginReflection();
  drawPiece(scale);
  
  o.setPosition(Dx, Dy);
  o.left(180);
  drawPiece(scale); 
  o.endReflection();
  
  o.setPosition(_Cx, _Cy);
  hHeading = o.towards(Bx, By);
  hDistance = o.distance(Bx, By);   

  o.popState();
}

