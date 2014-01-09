import processing.pdf.*;
import nl.tue.id.oogway.*;

int XSIZE=int(3.6*297);
int YSIZE=int(3.6*210);
  
String title = "No.28, Basic Type CG1CG2G1G2";
String summary = "\n\nNumber of arbitrary lines: 4\nNetwork: 333333\n4 Positions.";
String annotation = "";

boolean annotate = true;
boolean tessellating = false;
ArrayList done = new ArrayList();
boolean stop = false;
int counter = 0;

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
  o.setPenColor(0);
  o.setPenSize(2);
  if (annotate)font = createFont("Comic Sans MS", 32);
}

void draw() {

  counter ++;
  beginRecord(PDF, "CG1CG2G1G2i" + (annotate?"_Annotated_"+nf(counter, 3)+".pdf":".pdf"));

  background(255);
  //if(annotate) showGrid();

  o.setPosition(250, 600);
  tessellating = false;
  drawPiece(1.5);
  if (annotate) drawIntro();  

  if (stop) {
    endRecord();
    return;
  }

  o.setPosition(650, 400);
  tesselate(0.5);
  
  endRecord();
}

void tesselate(float scale) {
  o.pushState();

  tessellating = true;

  for (int i=0; i<3; i++) {
    o.pushState();
    for (int j=0; j<3; j++) {
      groupPositions(scale);
      if (stop) {
        o.popState();
        o.popState();
        return;
      }
      o.shift(hHeading, hDistance);
      
      if(j==2) continue;
      if (annotate && !done.contains("GROUP-0"+j) && !done.contains("ALLATONCE")) {
        done.add("GROUP-0"+j);
        o.popState();
        o.popState();
        stop = true;
        return;
      }
    }
    o.popState();
    o.shift(vHeading, vDistance);
    
    if(i==2) continue;
    if (annotate && !done.contains("GROUP-"+i) && !done.contains("ALLATONCE")) {
      done.add("GROUP-"+i);
      o.popState();
      stop = true;
      return;
    }
  }

  o.popState();
  
  if (annotate) highlightGroup(scale);
}

void drawPiece(float scale) {

  o.pushState();

  annotation = "Glide-reflect the arbitrary line AB  to CD (glide-reection axis H1I1). ";

  //AB
  Ax = o.xcor(); 
  Ay = o.ycor();
  o.pathForward(AB*scale, "AB.svg"); 
  Bx = o.xcor(); 
  By = o.ycor();

  drawPoint(Ax, Ay, 6*scale);
  drawPoint(Bx, By, 6*scale);

  if (annotate && !tessellating) {
    annotateText("A", Ax, Ay+15);
    annotateText("B", Bx, By+15);
  }

  if ( annotate && !done.contains("AB") && !done.contains("ALLATONCE")) {
    done.add("AB");
    o.popState();
    stop = true;
    return;
  }

  //H1I1
  o.left(angleBH1I1);
  float headingH1I1 = o.heading();
  float H1x = Ax*(1-ratioAH1) + Bx*ratioAH1, H1y = Ay*(1-ratioAH1) + By*ratioAH1;

  o.setPosition(H1x, H1y);
  o.shiftForward(H1I1*scale);
  float I1x = o.xcor(), I1y = o.ycor();
  //line(H1x, H1y, I1x, I1y);

  if (annotate && ! tessellating) {
    o.pushState();
    o.setPosition(H1x, H1y);
    o.setHeading(o.towards(I1x, I1y));
    o.shiftBackward(H1I1*scale/4);
    annotateText("H1", o.xcor()+15, o.ycor());
    o.dashForward(o.distance(I1x, I1y)+H1I1*scale/4);
    annotateText("I1", o.xcor()+15, o.ycor());
    o.popState();
  }

  if (annotate && !done.contains("H1I1") && !done.contains("ALLATONCE")) {
    done.add("H1I1");
    o.popState();
    stop = true;
    return;
  }

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

  drawPoint(Cx, Cy, 6*scale);
  drawPoint(Dx, Dy, 6*scale);

  if (annotate  && !tessellating) {
    annotateText("C", Cx, Cy-20);    
    annotateText("D", Dx, Dy-20);
  }

  if (annotate && !done.contains("CD") && !done.contains("ALLATONCE")) {
    done.add("CD");
    o.popState();
    stop = true;
    return;
  }

  annotation += "Draw the arbitrary line BC and glide-reflect it in the glide-reection axis H2I2 "
    + "which is perpendicular to H1I1, towards FE (E arbitrary.) ";

  //BC
  o.setPosition(Bx, By);
  o.setHeading(o.towards(Cx, Cy));
  o.pathForward(o.distance(Cx, Cy), "BC.svg");

  drawPoint(Bx, By, 6*scale);
  drawPoint(Cx, Cy, 6*scale);

  if (annotate && !done.contains("BC") && !done.contains("ALLATONCE")) {
    done.add("BC");
    o.popState();
    stop = true;
    return;
  }

  //H2I2
  float I2x = Bx*(1-ratioBI2) + Cx*ratioBI2, I2y = By*(1-ratioBI2) + Cy*ratioBI2;

  o.setPosition(I2x, I2y);
  o.setHeading(headingH1I1);
  o.left(90);
  o.shiftForward(H2I2*scale);
  float H2x = o.xcor(), H2y = o.ycor();
  //line(H2x, H2y, I2x, I2y);

  if (annotate && !tessellating) {
    o.pushState();
    o.setPosition(H2x, H2y);
    o.setHeading(o.towards(I2x, I2y));
    o.shiftBackward(H2I2*scale/4);
    annotateText("H2", o.xcor()-15, o.ycor()-15);
    o.dashForward(o.distance(I2x, I2y)+H2I2*scale/4);
    annotateText ("I2", o.xcor(), o.ycor()-15);
    o.popState();
  }

  if (annotate && !done.contains("H2I2") && !done.contains("ALLATONCE")) {
    done.add("H2I2");
    o.popState();
    stop = true;
    return;
  }

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

  drawPoint(Fx, Fy, 6*scale);
  drawPoint(Ex, Ey, 6*scale);

  if (annotate  && !tessellating) {
    annotateText("F", Fx-20, Fy);    
    annotateText("E", Ex-20, Ey);
  }

  if (annotate && !done.contains("FE") && !done.contains("ALLATONCE")) {
    done.add("FE");
    o.popState();
    stop = true;
    return;
  }


  annotation += "Connect D to F by a C-line and connect A to E in the same way.";

  //DF
  cline(Dx, Dy, Fx, Fy, "DM1.svg");

  drawPoint(Dx, Dy, 6*scale);
  drawPoint(Fx, Fy, 6*scale);
  drawMPoint((Dx+Fx)/2, (Dy+Fy)/2, 6*scale);

  if (annotate && !tessellating) {
    annotateText("M1", (Dx+Fx)/2-20, (Dy+Fy)/2);
  }

  if (annotate && !done.contains("DF") && !done.contains("ALLATONCE")) {
    done.add("DF");
    o.popState();
    stop = true;
    return;
  }

  //AE
  cline(Ax, Ay, Ex, Ey, "AM2.svg");

  drawPoint(Ax, Ay, 6*scale);
  drawPoint(Ex, Ey, 6*scale);
  drawMPoint((Ax+Ex)/2, (Ay+Ey)/2, 6*scale);

  if (annotate && !tessellating) {
    annotateText("M2", (Ax+Ex)/2-20, (Ay+Ey)/2);
  }

  if (annotate && !done.contains("AE") && !done.contains("ALLATONCE")) {
    done.add("AE");
    o.popState();
    stop = true;
    return;
  }

  annotation += summary;


  drawArrow(scale);

  o.popState();
}


void groupPositions(float scale) {
  o.pushState();

  drawPiece(scale);
  if (annotate && !done.contains("PIECE1") && !done.contains("ALLATONCE")) {
    done.add("PIECE1");
    o.popState();
    stop = true;
    return;
  }

  float _Bx = Bx, _By = By;
  float _Cx = Cx, _Cy = Cy;
  float _Dx = Dx, _Dy = Dy;
  float _Fx = Fx, _Fy = Fy;

  float angleABC = angleBetween(Ax, Ay, Bx, By, Cx, Cy);

  o.setPosition(Ex, Ey);
  o.right(180);
  drawPiece(scale);
  if (annotate && !done.contains("PIECE2") && !done.contains("ALLATONCE")) {
    done.add("PIECE2");
    o.popState();
    stop = true;
    return;
  }

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
  if (annotate && !done.contains("PIECE3") && !done.contains("ALLATONCE")) {
    done.add("PIECE3");
    o.popState();
    stop = true;
    return;
  }

  float angleFEA = angleBetween(Fx, Fy, Ex, Ey, Ax, Ay);
  float angleEAB = angleBetween(Ex, Ey, Ax, Ay, Bx, By);
  if (isRight(Ax, Ay, Fx, Fy, Ex, Ey)) {
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


void keyPressed() {
  if (!stop) return;
  if (key == 'a' || key == 'A') {
    done.add("ALLATONCE");
  }
  stop=false;
  redraw();
}



