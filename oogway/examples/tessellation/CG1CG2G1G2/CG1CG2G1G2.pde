import processing.pdf.*;
import nl.tue.id.oogway.*;

int XSIZE=int(3.6*297);
int YSIZE=int(3.6*210);

boolean annotate = true;
int stepCounter = 0;

//sides and angles defining the shape
float AB = 100;
float ratioAH1 = 0.45;
float H1I1 = 100;
float angleBH1I1 = 67;
float H2I2 = 100;
float ratioBI2 = 0.55;

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
  beginRecord(PDF, "CG1CG2G1G2" + (annotate?"_Annotated.pdf":".pdf"));
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate)font = createFont("Comic Sans MS", 32);
}

void draw() {
  background(255);
  //if(annotate) showGrid();

  o.setPosition(250, 600);
  drawPiece(1.5);

  if (annotate) drawPoints();
  if (annotate) drawAxes();
  if (annotate) drawIntro();
  
  o.setPosition(650, 400);
  tesselate(0.5);

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

  if (annotate) highlightGroup(scale);

  o.popState();
}

void drawPiece(float scale) {
  o.pushState();

  //Glide-reflect the arbitrary line AB to CD (glide-reection axis H1I1).

  //AB
  Ax = o.xcor(); 
  Ay = o.ycor();
  o.pathForward(AB*scale, "AB.svg"); 
  Bx = o.xcor(); 
  By = o.ycor();

  //H1I1
  o.left(angleBH1I1);
  float headingH1I1 = o.heading();
  float H1x = Ax*(1-ratioAH1) + Bx*ratioAH1, H1y = Ay*(1-ratioAH1) + By*ratioAH1;

  o.setPosition(H1x, H1y);
  o.shiftForward(H1I1*scale);
  float I1x = o.xcor(), I1y = o.ycor();
  //line(H1x, H1y, I1x, I1y);

  //CD

  o.setPosition(Ax, Ay);
  o.mirrorPosition(H1x, H1y, I1x, I1y);
  o.shiftForward(H1I1*scale);
  Cx = o.xcor();
  Cy = o.ycor();

  o.setPosition(Bx, By);
  o.mirrorPosition(H1x, H1y, I1x, I1y);
  o.shiftForward(H1I1*scale);
  Dx = o.xcor();
  Dy = o.ycor();

  o.setPosition(Cx, Cy);
  o.setHeading(o.towards(Dx, Dy));
  o.beginReflection();
  o.pathForward(o.distance(Dx, Dy), "AB.svg");
  o.endReflection();

  //Draw the arbitrary line BC and glide-reflect it in the glide-reection axis H2I2 "
  //which is perpendicular to H1I1, towards FE (E arbitrary.) 

  //BC
  o.setPosition(Bx, By);
  o.setHeading(o.towards(Cx, Cy));
  o.pathForward(o.distance(Cx, Cy), "BC.svg");

  //H2I2
  float I2x = Bx*(1-ratioBI2) + Cx*ratioBI2, I2y = By*(1-ratioBI2) + Cy*ratioBI2;
  o.setPosition(I2x, I2y);
  o.setHeading(headingH1I1);
  o.left(90);
  o.shiftForward(H2I2*scale);
  float H2x = o.xcor(), H2y = o.ycor();
  //line(H2x, H2y, I2x, I2y);

 
  //FE
  o.setPosition(Bx, By);
  o.mirrorPosition(H2x, H2y, I2x, I2y);
  o.shiftForward(H2I2*scale);
  Fx = o.xcor();
  Fy = o.ycor();
  
  o.setPosition(Cx, Cy);  
  o.mirrorPosition(H2x, H2y, I2x, I2y);
  o.shiftForward(H2I2*scale);
  Ex = o.xcor();
  Ey = o.ycor();
  
  o.setPosition(Fx, Fy);
  o.setHeading(o.towards(Ex, Ey));
  o.beginReflection();
  o.pathForward(o.distance(Ex, Ey), "BC.svg"); 
  o.endReflection(); 
  
  //Connect D to F by a C-line and connect A to E in the same way.
  
  //DF
  cline(Dx, Dy, Fx, Fy, "DM1.svg");
  
  //AE
  cline(Ax, Ay, Ex, Ey, "AM2.svg");

  o.popState();

  if (annotate) drawArrow(scale);
}


void groupPositions(float scale) {
  o.pushState();
  
  drawPiece(scale);
  float _Bx = Bx, _By = By;
  float _Cx = Cx, _Cy = Cy;
  float _Dx = Dx, _Dy = Dy;
  float _Fx = Fx, _Fy = Fy;
  
  float angleABC = findAngle(Ax, Ay, Bx, By, Cx, Cy);

  o.setPosition(Ex, Ey);
  o.right(180);
  drawPiece(scale);
  
  o.setPosition(_Dx, _Dy);
  vHeading = o.towards(Fx, Fy);
  vDistance = o.distance(Fx, Fy);  

  o.setPosition(Fx, Fy);
  o.setHeading(o.towards(Ex, Ey));
  o.right(angleABC);
  o.shiftForward(AB*scale);
  o.right(180);
  o.beginReflection();
  drawPiece(scale);
  o.endReflection();
  
  float angleFEA = findAngle(Fx, Fy, Ex, Ey, Ax, Ay);
  float angleEAB = findAngle(Ex, Ey, Ax, Ay, Bx, By);
  if(isRight(Ax, Ay, Fx, Fy, Ex, Ey)){
    println("yes");
    angleFEA = 360 - angleFEA;    
  }
  
  o.setPosition(Ex, Ey);
  float EA = o.distance(Ax, Ay);
  
  o.setPosition(_Cx, _Cy);
  o.setHeading(o.towards(_Bx, _By));
  o.left(angleFEA);
  o.shiftForward(EA);
  o.right(180-angleEAB);
  o.beginReflection();
  drawPiece(scale);
  o.endReflection();
  
  o.setPosition(_Fx, _Fy);
  hHeading = o.towards(Bx, By);
  hDistance = o.distance(Bx, By);
  
  o.popState();
}

