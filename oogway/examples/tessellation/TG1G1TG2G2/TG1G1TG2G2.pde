import processing.pdf.*;
import nl.tue.id.oogway.*;

boolean annotate = true;

/** NOTES
*
* The way TG1G1TG2G2 is constructed suggests that BFC and AED are Isosceles triangles, if we see
* the sides as staight lines. Oogway will take this into account when defining and constructing 
* the shape.
* 
**/

//sides and angles defining the shape
float AB = 100;
float AD = 125;
float angleBAD = 75;
float angleBAE = 105;
float angleABF = 135;

Oogway o;
PFont font;

//latest vertex coordinates
float Ax, Ay, Bx, By, Cx, Cy, Dx, Dy, Ex, Ey, Fx, Fy;


////for tessellating the groups of the pieces
float hDistance, hHeading;
float vDistance, vHeading;

void setup() {
  size(1069, 756); //int(3.6*297), int(3.6*210);
  o = new Oogway(this);
  noLoop(); 
  smooth();
  beginRecord(PDF, "TG1G1TG2G2" + (annotate?"_Annotated.pdf":".pdf"));
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate)font = createFont("Comic Sans MS", 32);
}

void draw() {
  background(255);
  // if(annotate) showGrid();

  o.left(15);

  o.setPosition(600, 450);
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

  //Connect A to a point E by an arbitrary line and glide-reflect AE towards ED. 

  //AE
  float AE = (AD/2) / cos(radians(angleBAE-angleBAD));
  o.recall("A");
  o.left(angleBAE);
  o.pathForward(AE*scale, "AE.svg");
  Ex = o.xcor(); 
  Ey = o.ycor();

  //ED
  o.setHeading(o.towards(Dx, Dy));
  o.beginReflection();
  o.pathForward(o.distance(Dx, Dy), "AE.svg");    
  o.endReflection();

  //Complete the figure by another pair of glide-reflected and connected lines BF, FC

  //BF
  float BF = (AD/2) / cos(radians(angleABF-(180-angleBAD)));
  o.recall("B");
  o.left(180-angleABF);
  o.pathForward(BF*scale, "BF.svg");
  Fx = o.xcor(); 
  Fy = o.ycor();

  //FC
  o.setHeading(o.towards(Cx, Cy));
  o.beginReflection();
  o.pathForward(o.distance(Cx, Cy), "BF.svg");
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

  o.setPosition(Fx, Fy);
  o.setHeading(o.towards(Cx, Cy));
  o.right(angleABF);
  o.shiftForward(AB*scale); 
  o.right(180);
  o.beginReflection(); 
  drawPiece(scale);
  o.endReflection();

  o.setPosition(_Ax, _Ay);
  hHeading = o.towards(Ex, Ey);
  hDistance = o.distance(Ex, Ey);

  o.popState();
}