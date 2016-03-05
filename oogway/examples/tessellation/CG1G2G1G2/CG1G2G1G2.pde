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
float Ax, Ay, Bx, By, Cx, Cy, Dx, Dy, Ex, Ey;


////for tessellating the groups of the pieces
float hDistance, hHeading;
float vDistance, vHeading;

void setup() {
  size(1069, 756); //int(3.6*297), int(3.6*210);
  o = new Oogway(this);
  noLoop(); 
  smooth();
  beginRecord(PDF, "CG1G2G1G2" + (annotate?"_Annotated.pdf":".pdf"));
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate)font = createFont("Comic Sans MS", 32);
}

void draw() {
  background(255);
  //if(annotate) showGrid();

  o.left(15);

  o.setPosition(650, 400);
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


  //Draw the arbitrary line BC and glide-reflect along the glide-reflection axis H2I2 towards AE 
  //(H2I2 _|_ H1I1 equidistant from A and C).

  //BC
  o.recall("B");
  float bc = o.towards(Cx, Cy);
  float BC = o.distance(Cx, Cy);
  o.setHeading(bc);
  o.pathForward(BC, "BC.svg");

  //AE
  o.recall("A");
  o.setHeading(bc);
  o.shiftForward(BC);
  Ex = o.xcor();
  Ey = o.ycor();
  o.beginReflection();
  o.pathBackward(BC, "BC.svg");
  o.endReflection();  
  
  //Complete the figure by a C-line DE.
  
  //DE
  cline(Dx, Dy, Ex, Ey, "DM.svg");

  o.popState();

  if (annotate) drawArrow(scale);
}


void groupPositions(float scale) {
  o.pushState();

  o.remember("O");
  drawPiece(scale);
  float _Bx = Bx, _By = By;

  o.right(180);
  drawPiece(scale);
  float _Cx = Cx, _Cy = Cy;  
  
  o.recall("O");
  o.shiftForward(AB*scale);
  o.shiftRight(180-angleBAD, AD*scale);
  o.left(2*angleBAD);
  o.beginReflection();
  drawPiece(scale);
  o.endReflection();

  o.recall("O");
  o.right(180);
  o.shiftForward(AB*scale);
  o.shiftRight(180-angleBAD, AD*scale);
  o.left(2*angleBAD);
  o.beginReflection();
  drawPiece(scale);
  o.endReflection();
  
  o.setPosition(Ex, Ey);
  hHeading = o.towards(_Bx, _By);
  hDistance = o.distance(_Bx, _By);
 
   o.setPosition(Ax, Ay);
  vHeading = o.towards(_Cx, _Cy);
  vDistance = o.distance(_Cx, _Cy); 

  o.popState();
}