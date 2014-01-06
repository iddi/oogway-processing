import processing.pdf.*;
import nl.tue.id.oogway.*;

int XSIZE=int(3.6*297);
int YSIZE=int(3.6*210);

boolean annotate = true;

//sides and angles defining the shape

Oogway o;
PFont font;

//latest vertex coordinates
float Ax, Ay, Bx, By, Cx, Cy, Dx, Dy, Ex, Ey, Fx, Fy;

float AB = 100;
float CD = 60;
float angleACD = 130;


////for tessellating the groups of the pieces
float hDistance, hHeading;
float vDistance, vHeading;

void setup() {
  size(XSIZE, YSIZE);
  o = new Oogway(this);
  noLoop(); 
  smooth();
  beginRecord(PDF, "C3C3C3C3C3C3" + (annotate?"_Annotated.pdf":".pdf"));
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate)font = createFont("Comic Sans MS", 32);
}

void draw() {
  background(255);

  o.left(60);

  o.setPosition(150, 450);
  drawPiece(1.5);

  if (annotate) drawPoints();
  if (annotate) drawIntro();

  o.setPosition(600, 370);
  tesselate(0.7);

  endRecord();
}

void tesselate(float scale) {
  o.pushState();

  for (int i=0; i<2; i++) {
    o.pushState();
    for (int j=0; j<2; j++) {
      groupPositions(scale);
      o.shift(hHeading, hDistance);
    }

    o.popState();
    o.shift(vHeading, vDistance);
  }

  if(annotate) highlightGroup(scale);
  
  o.popState();
}

void drawPiece(float scale) {
  o.pushState();

  //Turn the arbitrary line AB by 120 degrees into the position AC.

  //AB
  o.remember("A");
  Ax = o.xcor(); 
  Ay = o.ycor();
  o.pathForward(AB*scale, "AB.svg");
  Bx = o.xcor(); 
  By = o.ycor();

  //AC
  o.recall("A");
  o.right(120);
  o.pathForward(AB*scale, "AB.svg");
  Cx = o.xcor(); 
  Cy = o.ycor();

  // Turn another arbitrary line CD(D arbitrary) around D by 120 degrees into the position DE.

  //CD
  o.left(180-angleACD);
  o.pathForward(CD*scale, "CD.svg");
  Dx = o.xcor(); 
  Dy = o.ycor();

  //DE
  o.left(60);
  o.shiftForward(CD*scale);
  Ex = o.xcor(); 
  Ey = o.ycor();
  o.pathBackward(CD*scale, "CD.svg");

  //F is the third corner of the equilateral triangle ADF, the angle EFB being equal to 120 degrees.
  o.setPosition(Dx, Dy);
  o.setHeading(o.towards(Ax, Ay));
  o.right(60);
  o.shiftForward(o.distance(Ax, Ay));
  Fx = o.xcor(); 
  Fy = o.ycor();

  //EF
  o.setPosition(Ex, Ey);
  o.setHeading(o.towards(Fx, Fy));
  o.pathForward(o.distance(Fx, Fy), "EF.svg");  

  //BF
  o.setPosition(Bx, By);
  o.setHeading(o.towards(Fx, Fy));
  o.pathForward(o.distance(Fx, Fy), "EF.svg");  

  o.popState();

  if (annotate) drawArrow(scale);
}


void groupPositions(float scale) {
  o.pushState();

  drawPiece(scale);
  float _Fx = Fx, _Fy = Fy;

  o.right(120);
  drawPiece(scale);
  float _Fx_ = Fx, _Fy_ = Fy;

  o.right(120);
  drawPiece(scale);

  o.setPosition(Fx, Fy);
  hHeading = o.towards(_Fx, _Fy);
  hDistance = o.distance(_Fx, _Fy);

  vHeading = o.towards(_Fx_, _Fy_);
  vDistance = o.distance(_Fx_, _Fy_);

  o.popState();
}

