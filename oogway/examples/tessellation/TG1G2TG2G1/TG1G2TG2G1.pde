import processing.pdf.*;
import nl.tue.id.oogway.*;

int XSIZE=int(3.6*297);
int YSIZE=int(3.6*210);

boolean annotate = true;

//sides and angles defining the shape
float AB = 100;
float AD = 125;
float AF = 70;
float angleBAD = 75;
float angleBAF = 100;

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
  beginRecord(PDF, "TG1G2TG2G1" + (annotate?"_Annotated.pdf":".pdf"));
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
  
  if(annotate) highlightGroup(scale);

  o.popState();
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

  //glide-reflect another arbitrary line AF (F arbitrary) into EB. 

  //AF
  o.recall("A");
  o.left(angleBAF);
  o.pathForward(AF*scale, "AF.svg");
  Fx = o.xcor(); 
  Fy = o.ycor();
  
  //EB
  o.recall("B");
  o.left(angleBAD-(angleBAF-angleBAD));
  o.shiftForward(AF*scale);
  Ex = o.xcor(); 
  Ey = o.ycor();
  o.beginReflection();
  o.pathBackward(AF*scale, "AF.svg");
  o.endReflection();
  
  //Glide-reflect a third arbitrary line FD into CE.

  //FD
  o.setPosition(Fx, Fy);
  o.setHeading(o.towards(Dx, Dy));
  o.pathForward(o.distance(Dx, Dy), "FD.svg");    
  
  //CE
  o.setPosition(Cx, Cy);
  o.setHeading(o.towards(Ex, Ey));
  o.beginReflection();
  o.pathForward(o.distance(Ex, Ey), "FD.svg");
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

  o.setPosition(Cx, Cy);
  o.setHeading(180+o.towards(Dx, Dy));
  o.left(angleBAD-(angleBAF-angleBAD));
  o.shiftForward(AF*scale); 
  o.right(180-angleBAF);
  o.beginReflection(); 
  drawPiece(scale);
  o.endReflection();

  o.setPosition(_Ax, _Ay);
  hHeading = o.towards(Ex, Ey);
  hDistance = o.distance(Ex, Ey);

  o.popState();
}

