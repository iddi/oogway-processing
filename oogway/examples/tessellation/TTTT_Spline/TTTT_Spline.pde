import nl.tue.id.oogway.*;
import processing.pdf.*;

PFont font;

void setup() {
  noLoop(); smooth();
  size(1069, 756); //int(3.6*297), int(3.6*210);
  beginRecord(PDF, "TTTT_Spline.pdf");
  //this was tricky, see JunTestFont or email 20-12-2011
}

void draw() {
  fill(0);
  stroke(0);
  background(255);
  Oogway o = new Oogway(this);
  o.setPenSize(2);
  font = createFont("Comic Sans MS", 32); 
  drwIntro();
  TTTT tttt = new TTTT(o);

  //create one big basic figure
  tttt.ABCD(new PPoint(250, 600), 0);

  //create one smaller version
  PPoint origin = new PPoint(670, 660);
  tttt.ABCDsmallversion(origin, 0);

  //from this one derive the translation vectors
  //for the entire two-block and repeat by translations;
  //sorry for the double lines;
  PVector T1 = PVector.sub(tttt.B, tttt.A);
  PVector T2 = PVector.sub(tttt.D, tttt.A);
  for (int i=0;i<3;i++) {//was 2
    for (int j=0;j<3;j++) { //was 3
      PPoint T = new PPoint(origin.x, origin.y);
      T.add(PVector.mult(T1, i));
      T.add(PVector.mult(T2, j));
      tttt.ABCDsmallversion(T, 0);
    }
  }

  endRecord();
}

class PPoint extends PVector {
  PPoint(float x, float y) {
    super(x, y);
  }
  //the following method does not change "this" but makes a new point
  //I would have preferred a static method,  but that was not allowed
  //inpol interpolates "this" and B, to give a middle point, half way 
  PPoint intpol(PPoint B) {
    PVector M = mult(PPoint.add(this, B), 0.5);
    return new PPoint(M.x, M.y);
  }
  PPoint intpol(PPoint B, float f) {
    PVector M = PPoint.add(mult(this, 1-f), mult(B, f));
    return new PPoint(M.x, M.y);
  }
}

void setPosition(Oogway o, PPoint P) {
  o.setPosition(P.x, P.y);
}
PPoint getPosition(Oogway o) {
  return new PPoint(o.xcor(), o.ycor());
}
void setRotation(Oogway o, float theta) {
  o.setHeading(theta);
}
float getRotation(Oogway o) {
  return int(o.heading());
}

class TTTT {
  Oogway o;
  //designed for vertical 
  //glide reflection axis only
  PPoint A, B, C, D, T1, T2;
  float a2b, a2d;
  TTTT(Oogway orp) {
    o=orp;
  }
  void ABCD(PPoint inipos, int inidir) {
    // this method uses one arbitrary line AB and one arbitrary line AD;
    // the procedure encodes the logic of how the lines are positioned with 
    // respect to each other and the points A,B,C,D
    setPosition(o, inipos);
    setRotation(o, inidir);
    int s = 20; //scale, good values are 20, 24
    A = getPosition(o);
    //create AB arbitrarily
    A2B(o, s); 
    a2b = getRotation(o);
    B = getPosition(o);
    setPosition(o, A);
    setRotation(o, inidir);
    //create AD arbitrarily
    A2D(o, s); 
    D = getPosition(o);
    setRotation(o, inidir);
    //create DC as a copy of AB
    A2B(o, s);
    C = getPosition(o);
    setPosition(o, B);
    setRotation(o, inidir);
    //create BC as a copy of AD
    A2D(o, s);
    //give some auxilliary lines
    setPosition(o, A);
    A2Ddashed(o, s, D);
    setPosition(o, C);
    A2Ddashed(o, s, B);
    a2d = o.heading();
    T1 = A.intpol(D, .7);
    T2 = B.intpol(C, .7);
    setPosition(o, A.intpol(B).intpol(C.intpol(D)));
    setRotation(o, a2d);
    drwArrowFull(o, s);
    //done
    drwA(A, s);
    drwB(B, s);
    drwC(C, s);
    drwD(D, s);
    drwT(T1, s);
    drwT(T2, s);
  }//end ABCD
  void ABCDsmallversion(PPoint inipos, int inidir) {
    //always run ABCD (the big version first
    //it fills in the a2d direction etc.
    setPosition(o, inipos);
    setRotation(o, inidir);
    int s = 8; //scale, good values are 4,5,8,20, 24
    A = getPosition(o);
    A2B(o, s);
    B = getPosition(o);
    setPosition(o, A);
    setRotation(o, inidir);
    A2D(o, s);
    D = getPosition(o);
    setRotation(o, inidir);
    A2B(o, s);
    C = getPosition(o);
    setPosition(o, B);
    setRotation(o, inidir);
    A2D(o, s);
    //give one auxilliary line
    setPosition(o, A.intpol(B).intpol(C.intpol(D)));
    setRotation(o, a2d);
    //drwArrowFull(o,s);
    //done
    //drwA(A,s);
    //drwB(B,s);
    //drwC(C,s);
    //drwD(D,s);
  }//end ABCDsmallversion
}// end TTTT



void drwArrowFull(Oogway o, int scalefactor) {
  //draw a big full arrow
  //s must be prferably arround 20
  o.setPenColor(255, 0, 0);
  fill(255,0,0);
  int s=scalefactor;
  //outer arrow
  o.forward(2*s);
  o.stamp(s/2);
}


void A2B(Oogway o, int scalefactor) {
  //made by my own program escherMaker, 
  //using something similar to Escher's pegaus 105 as input
  o.setPenColor(0, 0, 0);
  float s=float(scalefactor)/25;
  o.beginSpline();
  o.left(52.1);
  o.forward(s*34.0);
  o.left(84.2);
  o.forward(s*30.0);
  o.left(-52.3);
  o.forward(s*38.0);
  o.left(-83.9);
  o.forward(s*36.0);
  o.left(22.4);
  o.forward(s*68.0);
  o.left(42.7);
  o.forward(s*14.0);
  o.left(-115.6);
  o.forward(s*29.0);
  o.left(49.7);
  o.forward(s*81.0);
  o.left(-91.1);
  o.forward(s*31.0);
  o.left(40.0);
  o.forward(s*17.0);
  o.left(6.8);
  o.forward(s*24.0);
  o.left(-54.4);
  o.forward(s*18.0);
  o.left(-31.8);
  o.forward(s*54.0);
  o.left(-4.5);
  o.forward(s*50.0);
  o.left(14.3);
  o.forward(s*21.0);
  o.left(31.4);
  o.forward(s*15.0);
  o.left(5.1);
  o.forward(s*11.0);
  o.left(70.7);
  o.forward(s*65.0);
  o.left(99.7);
  o.forward(s*27.0);
  o.left(35.2);
  o.forward(s*17.0);
  o.left(-90.4);
  o.forward(s*155.0);
  o.endSpline();
}


void A2D(Oogway o, int scalefactor) {
  //made by my own program escherMaker, 
  //using something similar to Escher's pegaus 105 as input
  float s=float(scalefactor)/25;
  o.beginSpline();
  o.left(100.3);
  o.setPenColor(0, 0, 0);
  o.forward(s*11.0);
  o.left(37.8);
  o.forward(s*50.0);
  o.left(-44.8);
  o.forward(s*17.0);
  o.left(-53.1);
  o.forward(s*17.0);
  o.left(35.0);
  o.forward(s*43.0);
  o.left(-56.3);
  o.forward(s*33.0);
  o.left(1.3);
  o.forward(s*28.0);
  o.left(29.8);
  o.forward(s*15.0);
  o.left(35.0);
  o.forward(s*24.0);
  o.left(52.4);
  o.forward(s*14.0);
  o.left(19.0);
  o.forward(s*15.0);
  o.left(-2.2);
  o.forward(s*23.0);
  o.left(11.4);
  o.forward(s*4.0);
  o.left(16.4);
  o.forward(s*24.0);
  o.left(87.6);
  o.forward(s*11.0);
  o.left(82.5);
  o.forward(s*23.0);
  o.left(-61.1);
  o.forward(s*24.0);
  o.left(-59.2);
  o.forward(s*11.0);
  o.left(1.8);
  o.forward(s*13.0);
  o.left(-24.2);
  o.forward(s*8.0);
  o.left(-73.0);
  o.forward(s*23.0);
  o.left(0.2);
  o.forward(s*41.0);
  o.left(-71.9);
  o.forward(s*49.0);
  o.left(-61.1);
  o.forward(s*59.0);
  o.left(78.5);
  o.forward(s*15.0);
  o.left(-21.9);
  o.forward(s*34.0);
  o.left(-8.9);
  o.forward(s*86.0);
  o.left(42.8);
  o.forward(s*13.0);
  o.left(84.0);
  o.forward(s*38.0);
  o.left(15.0);
  o.forward(s*55.0);
  o.endSpline();
}

void roundCornerRight180(Oogway o, int d) {
  //auxilliary for A2D
  o.right(30);
  for (int i=0; i<5; i++) {
    o.forward(d/4);
    o.right(30);
  }
}
void roundCornerLeft180(Oogway o, int d) {
  o.left(30);
  for (int i=0; i<5; i++) {
    o.forward(d/4);
    o.left(30);
  }
}
void roundCornerLeft90(Oogway o, int d) {
  o.left(30);
  for (int i=0; i<2; i++) {
    o.forward(d/4);
    o.left(30);
  }
}

void A2Ddashed(Oogway o, int scalefactor, PVector D) {
  // this will be a coloured dashed line, straight, only for explanation
  // typically started in A, it will shoot towards position D
  o.setPenColor(0, 0, 255);
  int d=scalefactor;
  o.beginDash();
  o.setHeading(o.towards(D.x, D.y));
  o.forward(o.distance(D.x, D.y));
  o.endDash();
}

void drwIntro() {
  textFont(font, 32);
  text("No.1, Basic Type TTTT", 200, 50);
  textFont(font, 16);
  text("Shift the arbitrary line AB to DC, such that ABCD are the corners of a parallelogram (translation vector AD). Draw another arbitrary line from A to D and shift it into the position BC (translation vector AB)."
    , 200, 100, 700, 200); 
  text("Network 4444,"
    , 650, 200, 700, 100); 
  text("1 position."
    , 650, 220, 700, 100);
}

void drwA(PVector p, int scalefactor) {
  //to mark the points and write their name;
  //(name writing only only for the big versions);
  int d=scalefactor/2;
  stroke(255, 0, 0);
  fill(255, 0, 0);
  ellipse(p.x, p.y, d+2, d+2); 
  if (d>5) { 
    textFont(font, 32); 
    text("A", p.x-10, p.y+35);
  }
}

void drwB(PVector p, int scalefactor) {
  int d=scalefactor/2;
  strokeWeight(d/4+2);
  stroke(255, 0, 0);
  fill(255, 0, 0);
  ellipse(p.x, p.y, d+2, d+2); 
  if (d>5) { 
    textFont(font, 32);
    text("B", p.x-20, p.y+35);
  }
}

void drwC(PVector p, int scalefactor) {
  int d=scalefactor/2;
  strokeWeight(d/4+2);
  stroke(255, 0, 0);
  fill(255, 0, 0);
  ellipse(p.x, p.y, d+2, d+2); 
  if (d>5) { 
    textFont(font, 32); 
    text("C", p.x-10, p.y-10);
  }
}

void drwD(PVector p, int scalefactor) {
  int d=scalefactor/2;
  strokeWeight(d/4+2);
  stroke(255, 0, 0);
  fill(255, 0, 0);
  ellipse(p.x, p.y, d+2, d+2); 
  if (d>5) { 
    textFont(font, 32); 
    text("D", p.x-10, p.y-12);
  }
}
void drwT(PVector p, int scalefactor) {
  int d=scalefactor/2;
  strokeWeight(d/4+2);
  stroke(0, 0, 255);
  fill(0, 0, 255);
  if (d>5) { 
    textFont(font, 32); 
    text("T", p.x+5, p.y-12);
  }
}