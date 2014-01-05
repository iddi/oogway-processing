import processing.pdf.*;
import nl.tue.id.oogway.*;

int XSIZE=int(3.6*297);
int YSIZE=int(3.6*210);

boolean annotate = true;

//sides and angles defining the shape
float AB = 100;
float angleABC = 90;

Oogway o;
PFont font;

//latest vertex coordinates
float Ax, Ay, Bx, By, Cx, Cy;


//for tessellating the groups of the pieces
float hDistance, hHeading;
float vDistance, vHeading;

void setup() {
  size(XSIZE, YSIZE);
  o = new Oogway(this);
  noLoop(); 
  smooth();
  beginRecord(PDF, "CGG" + (annotate?"_Annotated.pdf":".pdf"));
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
    for (int j=0; j<3; j++) {
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

  //Bring the arbitrary line AB by glide-reflection into the position BC such that it connects, 
  //the angle ABC being arbitrary (glide-reflection axis HI parallel to AC having the same
  // distance from A and B).

  //AB
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

  //Then draw the arbitrary line AD and glide-reflect it into CB

 cline(Cx, Cy, Ax, Ay, "CM.svg");

  o.popState();

  if (annotate) drawArrow(scale);
}


void groupPositions(float scale) {
  o.pushState();

  o.remember("A");
  drawPiece(scale);
  float _Bx = Bx, _By = By; 
  
  vHeading = 180 + o.towards(Cx, Cy);
  vDistance = o.distance(Cx, Cy);
  
  o.setPosition(Cx, Cy);
  o.left(180);
  drawPiece(scale);

  o.setPosition(Bx, By);
  hHeading = o.towards(_Bx, _By);
  hDistance = o.distance(_Bx, _By);   
  
  o.recall("A");
  o.setHeading(o.towards(Bx, By));
  o.shiftBackward(o.distance(Bx, By));
  
  o.beginReflection();
  drawPiece(scale);
  
  o.setPosition(Cx, Cy);
  o.left(180);
  drawPiece(scale);  
  o.endReflection();

  o.popState();
}

