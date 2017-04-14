//(c) 2016-2017 Mayra Goevaerts w.f.goevaerts@student.tue.nl
//for the elective DBM150 Golden Ratio and Generative Arts

// --- A phyllotaxy spiral combined with grundyp CGG --
//The spiral is created based on the golden angle and fibonnaci
//The code creates a phyllotaxix (8, 13) 
//Grundtyp CGG is implemented and shapes can be created by dragging the anchor points to other positions. The lines were given the name according to this grundtyp.(
//Used parts of 'Example 8: Basic Phyllotaxy Spiral' by Jim Bumgardner [1] (//krazydad.com/tutorials/circles_js/showexample.php?ex=basic_phyllo)

import processing.pdf.*;

PVector[] coordinates; // store coordinates of the corners of the interactive triangle
float[][] CB_Points = new float[10][2]; // stores coordinates of interactive line
float[][] originalCB_Points = new float[10][2]; // stores initial coordinates of interactive line CB
float[][] MA_Points = new float[10][2]; // stores coordinates of interactive line MA
float[][] originalMA_Points = new float[10][2]; // stores initial coordinates of interactive line MA
float[][] Perp_Offset = new float[10][2]; // stores the parallel and perpendicular offset of a moved anchor from its initial 
float[][] Para_Offset = new float[10][2]; //stores the parallel and perpendicular offset of a moved anchor from its initial 

int Anchor_Grab = 0;
int MA_line = 0;
int CB_line = 0;

boolean record;

void setup() {
  size(800, 800);
  smooth();
  background(255);
  noFill();
  coordinates = new PVector [100];

  for (int i = 1; i <= 21; i++) {   // Performing drawLineAB function once to receive coordinates for corner coordinates for interactive triangle
    drawLineAB(i);
  }

  for (int i = 1; i <= 9; i++) {   // Create arrays to store values for interactive anchors for line CB
    originalCB_Points[i][0] = ((0.1 * i) * coordinates[85].x) + ((1-0.1*i)*coordinates[72].x);
    originalCB_Points[i][1] = (0.1 * i * coordinates[85].y) + ((1-0.1*i)*coordinates[72].y);
    CB_Points[i][0] = originalCB_Points[i][0];
    CB_Points[i][1] = originalCB_Points[i][1];
  }

  for (int i = 1; i <= 4; i++) {   // Create arrays to store values for interactive anchors for line MA
    originalMA_Points[i][0] = ((0.1 * i) * coordinates[85].x) + ((1-0.1*i)*coordinates[93].x);
    originalMA_Points[i][1] = ((0.1 * i) * coordinates[85].y) + ((1-0.1*i)*coordinates[93].y);
    MA_Points[i][0] = originalMA_Points[i][0];
    MA_Points[i][1] = originalMA_Points[i][1];
  }
}

float phi = (sqrt(5)+1)/2 - 1; // golden ratio [1]
float golden_angle = phi * TWO_PI; // golden angle [1]
int   nbr_circles = 100; // number of vertices drawn [1]
float cx = 400; // center point x [1]
float cy = 400; // center point y [1]
float outer_rad = 360; // radius of spiral [1]
float sm_diameter = 0; // diameter of smaller circle points [1]
float angle_incr = golden_angle; // [1]

void draw() { 

  if (record) {
    beginRecord(PDF, "Frame-####.pdf"); 
    noFill();
  }

  background(255);

  // Draw complete figure

  drawLineCA(1);
  drawLineCA_invert(2);
  drawLineCA(3);
  drawLineCA_invert(4);
  drawLineCA(5);
  drawLineCA_invert(6);
  drawLineCA(7);
  drawLineCA_invert(8);

  for (int i = 1; i <= 13; i++) {
    drawLineCB(i);
  }

  for (int i = 1; i <= 21; i++) {
    drawLineAB(i);
  }

  // Draw corners of interactive triangle

  ellipse(coordinates[85].x, coordinates[85].y, 7, 7); // Bovenste
  ellipse(coordinates[72].x, coordinates[72].y, 7, 7); // Rechtse
  ellipse(coordinates[93].x, coordinates[93].y, 7, 7); // Onderste

  // Interactivity 

  if (mousePressed) {
    if (Anchor_Grab == 0) {
      for (int i=1; i<=9; i++) {
        if (dist(CB_Points[i][0], CB_Points[i][1], mouseX, mouseY) < 5) {
          Anchor_Grab = i;
          CB_line = 1;
        }
        if (dist(MA_Points[i][0], MA_Points[i][1], mouseX, mouseY) < 5) {
          Anchor_Grab = i;
          MA_line = 1;
        }
      }
    } else {
      if (CB_line == 1) {
        CB_Points[Anchor_Grab][0] = mouseX;
        CB_Points[Anchor_Grab][1] = mouseY;

        // Calculate offset and angle of ofsetting

        float alpha = atan((coordinates[85].y - coordinates[72].y)/(coordinates[85].x - coordinates[72].x));
        float beta = atan((mouseY - originalCB_Points[Anchor_Grab][1]) / (mouseX- originalCB_Points[Anchor_Grab][0]));
        float gamma = PI/2 - beta + alpha;
        float offset = sqrt(pow(mouseY - originalCB_Points[Anchor_Grab][1], 2) + pow(mouseX - originalCB_Points[Anchor_Grab][0], 2));

        if (mouseX < originalCB_Points[Anchor_Grab][0]) { 
          gamma = gamma - PI;
        }

        Perp_Offset[Anchor_Grab][0] =  offset * sin(gamma); // Parallel offset
        Perp_Offset[Anchor_Grab][1] =  offset * cos(gamma); // Perpendicular offset
      }
      if (MA_line == 1) {
        MA_Points[Anchor_Grab][0] = mouseX;
        MA_Points[Anchor_Grab][1] = mouseY;

        // Calculate offset and angle of ofsetting

        float alpha = atan((coordinates[85].y - coordinates[93].y)/(coordinates[85].x - coordinates[93].x));
        float beta = atan((mouseY - originalMA_Points[Anchor_Grab][1]) / (mouseX- originalMA_Points[Anchor_Grab][0]));
        float gamma = PI/2 - beta + alpha;
        float offset = sqrt(pow(mouseY - originalMA_Points[Anchor_Grab][1], 2) + pow(mouseX - originalMA_Points[Anchor_Grab][0], 2));

        if (mouseX < originalMA_Points[Anchor_Grab][0]) { 
          gamma = gamma - PI;
        }

        Para_Offset[Anchor_Grab][0] =  offset * sin(gamma); // Parallel
        Para_Offset[Anchor_Grab][1] =  offset * cos(gamma); // Loodrecht
      }
    }
  } else { //mouseReleased
    Anchor_Grab = 0;
    CB_line = 0;
    MA_line = 0;
  }

  // Draw interactive lines

  beginShape();
  curveVertex(coordinates[72].x, coordinates[72].y);
  curveVertex(coordinates[72].x, coordinates[72].y);
  for (int i = 1; i <= 9; i++) {
    curveVertex(CB_Points[i][0], CB_Points[i][1]);
    ellipse(CB_Points[i][0], CB_Points[i][1], 5, 5);
  }
  curveVertex(coordinates[85].x, coordinates[85].y);
  curveVertex(coordinates[85].x, coordinates[85].y);
  endShape();

  beginShape();
  curveVertex(coordinates[93].x, coordinates[93].y);
  curveVertex(coordinates[93].x, coordinates[93].y);
  for (int i = 1; i <= 4; i++) {
    curveVertex(MA_Points[i][0], MA_Points[i][1]);
    ellipse(MA_Points[i][0], MA_Points[i][1], 5, 5);
  }
  curveVertex(((0.5*coordinates[85].x)+(0.5*coordinates[93].x)), ((0.5*coordinates[85].y)+(0.5*coordinates[93].y)));
  curveVertex(((0.5*coordinates[85].x)+(0.5*coordinates[93].x)), ((0.5*coordinates[85].y)+(0.5*coordinates[93].y)));
  endShape();

  if (record) {
    endRecord();
    record = false;
  }
}

void keyPressed() { // Making exporting a .PDF possible
  println("Saved.");
  record = true;
}

void drawLineCA(int n) {
  beginShape();
  vertex(cx, cy);
  for (int i = n; i <= nbr_circles; i = i+8) {

    // Function for spiral

    float ratio = i/(float)nbr_circles; // [1]
    float spiral_rad = ratio * outer_rad; // [1]
    float angle = i*angle_incr; // [1]
    float x = cx + cos(angle) * spiral_rad;// [1]
    float y = cy + sin(angle) * spiral_rad;// [1]

    // Making sure the starting point is > 0

    float prev_i = i-8;
    if (prev_i <= 0) {
      prev_i = prev_i + 8;
    }

    // Defining the previous point

    float prev_ratio = prev_i/(float)nbr_circles;
    float prev_spiral_rad = prev_ratio * outer_rad;
    float prev_angle = prev_i*angle_incr;
    float prev_x = cx + cos(prev_angle) * prev_spiral_rad;
    float prev_y = cy + sin(prev_angle) * prev_spiral_rad; 

    // Defining 9 point between (x,y) and (prev_x, prev_y) with interpolation

    float ix = (0.90*prev_x)+(0.10*x);
    float iy = (0.90*prev_y)+(0.10*y);

    float jx = (0.80*prev_x)+(0.20*x);
    float jy = (0.80*prev_y)+(0.20*y);

    float kx = (0.70*prev_x)+(0.30*x);
    float ky = (0.70*prev_y)+(0.30*y);

    float lx = (0.60*prev_x)+(0.40*x);
    float ly = (0.60*prev_y)+(0.40*y);

    float mx = (x+prev_x)/2;
    float my = (y+prev_y)/2;

    float nx = (0.40*prev_x)+(0.60*x);
    float ny = (0.40*prev_y)+(0.60*y);

    float ox = (0.30*prev_x)+(0.70*x);
    float oy = (0.30*prev_y)+(0.70*y);

    float px = (0.20*prev_x)+(0.80*x);
    float py = (0.20*prev_y)+(0.80*y);

    float qx = (0.10*prev_x)+(0.90*x);
    float qy = (0.10*prev_y)+(0.90*y);

    // Perform offsetting

    float offset_angle = atan((prev_y-y)/(x-prev_x));   // Calculate angle of line
    if (prev_x > x) {
      offset_angle = offset_angle + PI;
    }

    ix = ix + ( Para_Offset[1][1])*sin(offset_angle)*ratio - ( -Para_Offset[1][0]) *cos(offset_angle)*ratio;    // A  (to know which point should be which in the symmetry)
    iy = iy + ( Para_Offset[1][1])*cos(offset_angle)*ratio + ( -Para_Offset[1][0]) *sin(offset_angle)*ratio;

    jx = jx + ( Para_Offset[2][1])*sin(offset_angle)*ratio - ( -Para_Offset[2][0]) *cos(offset_angle)*ratio;    // B
    jy = jy + ( Para_Offset[2][1])*cos(offset_angle)*ratio + ( -Para_Offset[2][0]) *sin(offset_angle)*ratio;

    kx = kx + ( Para_Offset[3][1])*sin(offset_angle)*ratio - ( -Para_Offset[3][0]) *cos(offset_angle)*ratio;    // C
    ky = ky + ( Para_Offset[3][1])*cos(offset_angle)*ratio + ( -Para_Offset[3][0]) *sin(offset_angle)*ratio;

    lx = lx + ( Para_Offset[4][1])*sin(offset_angle)*ratio - ( -Para_Offset[4][0]) *cos(offset_angle)*ratio;    // D
    ly = ly + ( Para_Offset[4][1])*cos(offset_angle)*ratio + ( -Para_Offset[4][0]) *sin(offset_angle)*ratio;

    //----- Symmetry in line CA: mirror and invert points above (note: the centerpoint never has offsetting so stays the same)

    nx = nx + ( -Para_Offset[4][1])*sin(offset_angle)*ratio - ( Para_Offset[4][0]) *cos(offset_angle)*ratio;    // -D
    ny = ny + ( -Para_Offset[4][1])*cos(offset_angle)*ratio + ( Para_Offset[4][0]) *sin(offset_angle)*ratio;

    ox = ox + ( -Para_Offset[3][1])*sin(offset_angle)*ratio - ( Para_Offset[3][0]) *cos(offset_angle)*ratio;    // -C
    oy = oy + ( -Para_Offset[3][1])*cos(offset_angle)*ratio + ( Para_Offset[3][0]) *sin(offset_angle)*ratio;

    px = px + ( -Para_Offset[2][1])*sin(offset_angle)*ratio - ( Para_Offset[2][0]) *cos(offset_angle)*ratio;    // -B
    py = py + ( -Para_Offset[2][1])*cos(offset_angle)*ratio + ( Para_Offset[2][0]) *sin(offset_angle)*ratio;

    qx = qx + ( -Para_Offset[1][1])*sin(offset_angle)*ratio - ( Para_Offset[1][0]) *cos(offset_angle)*ratio;    // -A
    qy = qy + ( -Para_Offset[1][1])*cos(offset_angle)*ratio + ( Para_Offset[1][0]) *sin(offset_angle)*ratio;

    // Draw points and connect with line

    curveVertex(prev_x, prev_y);
    curveVertex(ix, iy);
    curveVertex(jx, jy);
    curveVertex(kx, ky);
    curveVertex(lx, ly);
    curveVertex(mx, my);
    curveVertex(nx, ny);
    curveVertex(ox, oy);
    curveVertex(px, py);
    curveVertex(qx, qy);
    curveVertex(x, y);
    curveVertex(x, y);
    vertex(x, y);
  } 
  endShape();
} 

void drawLineCA_invert(int n) { // Line CA alternates and mirrors according to grundtyp CGG
  beginShape();
  vertex(cx, cy);
  for (int i = n; i <= nbr_circles; i = i+8) {

    // Function for spiral

    float ratio = i/(float)nbr_circles; // [1]
    float spiral_rad = ratio * outer_rad; // [1]
    float angle = i*angle_incr; // [1]
    float x = cx + cos(angle) * spiral_rad;// [1]
    float y = cy + sin(angle) * spiral_rad;// [1]

    // Making sure the starting point is > 0

    float prev_i = i-8;
    if (prev_i <= 0) {
      prev_i = prev_i + 8;
    }

    // Defining the previous point

    float prev_ratio = prev_i/(float)nbr_circles;
    float prev_spiral_rad = prev_ratio * outer_rad;
    float prev_angle = prev_i*angle_incr;
    float prev_x = cx + cos(prev_angle) * prev_spiral_rad;
    float prev_y = cy + sin(prev_angle) * prev_spiral_rad; 

    // Defining 9 point between (x,y) and (prev_x, prev_y) with interpolation

    float ix = (0.90*prev_x)+(0.10*x);
    float iy = (0.90*prev_y)+(0.10*y);

    float jx = (0.80*prev_x)+(0.20*x);
    float jy = (0.80*prev_y)+(0.20*y);

    float kx = (0.70*prev_x)+(0.30*x);
    float ky = (0.70*prev_y)+(0.30*y);

    float lx = (0.60*prev_x)+(0.40*x);
    float ly = (0.60*prev_y)+(0.40*y);

    float mx = (x+prev_x)/2;
    float my = (y+prev_y)/2;

    float nx = (0.40*prev_x)+(0.60*x);
    float ny = (0.40*prev_y)+(0.60*y);

    float ox = (0.30*prev_x)+(0.70*x);
    float oy = (0.30*prev_y)+(0.70*y);

    float px = (0.20*prev_x)+(0.80*x);
    float py = (0.20*prev_y)+(0.80*y);

    float qx = (0.10*prev_x)+(0.90*x);
    float qy = (0.10*prev_y)+(0.90*y);

    // Perform offsetting

    float offset_angle = atan((prev_y-y)/(x-prev_x)); // Calculate angle of line 
    if (prev_x > x) {
      offset_angle = offset_angle + PI;
    }

    ix = ix + ( -Para_Offset[1][1])*sin(offset_angle)*ratio - ( -Para_Offset[1][0]) *cos(offset_angle)*ratio;    //-A (to know which point should be which in the symmetry)
    iy = iy + ( -Para_Offset[1][1])*cos(offset_angle)*ratio + ( -Para_Offset[1][0]) *sin(offset_angle)*ratio;

    jx = jx + ( -Para_Offset[2][1])*sin(offset_angle)*ratio - ( -Para_Offset[2][0]) *cos(offset_angle)*ratio;    //-B
    jy = jy + ( -Para_Offset[2][1])*cos(offset_angle)*ratio + ( -Para_Offset[2][0]) *sin(offset_angle)*ratio;

    kx = kx + ( -Para_Offset[3][1])*sin(offset_angle)*ratio - ( -Para_Offset[3][0]) *cos(offset_angle)*ratio;    //-C
    ky = ky + ( -Para_Offset[3][1])*cos(offset_angle)*ratio + ( -Para_Offset[3][0]) *sin(offset_angle)*ratio;  

    lx = lx + ( -Para_Offset[4][1])*sin(offset_angle)*ratio - ( -Para_Offset[4][0]) *cos(offset_angle)*ratio;    //-D
    ly = ly + ( -Para_Offset[4][1])*cos(offset_angle)*ratio + ( -Para_Offset[4][0]) *sin(offset_angle)*ratio;

    //----- Symmetry in line CA: mirror and invert points above (note: the centerpoint never has offsetting so stays the same)

    nx = nx + ( Para_Offset[4][1])*sin(offset_angle)*ratio - ( Para_Offset[4][0]) *cos(offset_angle)*ratio;    // D
    ny = ny + ( Para_Offset[4][1])*cos(offset_angle)*ratio + ( Para_Offset[4][0]) *sin(offset_angle)*ratio;  

    ox = ox + ( Para_Offset[3][1])*sin(offset_angle)*ratio - ( Para_Offset[3][0]) *cos(offset_angle)*ratio;    // C
    oy = oy + ( Para_Offset[3][1])*cos(offset_angle)*ratio + ( Para_Offset[3][0]) *sin(offset_angle)*ratio;

    px = px + ( Para_Offset[2][1])*sin(offset_angle)*ratio - ( Para_Offset[2][0]) *cos(offset_angle)*ratio;    // B
    py = py + ( Para_Offset[2][1])*cos(offset_angle)*ratio + ( Para_Offset[2][0]) *sin(offset_angle)*ratio;

    qx = qx + ( Para_Offset[1][1])*sin(offset_angle)*ratio - ( Para_Offset[1][0]) *cos(offset_angle)*ratio;    // A
    qy = qy + ( Para_Offset[1][1])*cos(offset_angle)*ratio + ( Para_Offset[1][0]) *sin(offset_angle)*ratio;

    // Draw points and connect with line

    curveVertex(prev_x, prev_y);
    curveVertex(ix, iy);
    curveVertex(jx, jy);
    curveVertex(kx, ky);
    curveVertex(lx, ly);
    curveVertex(mx, my);
    curveVertex(nx, ny);
    curveVertex(ox, oy);
    curveVertex(px, py);
    curveVertex(qx, qy);
    curveVertex(x, y);
    curveVertex(x, y);
    vertex(x, y);
  } 
  endShape();
} 

void drawLineCB(int n) {
  beginShape();
  vertex(cx, cy);
  for (int i = n; i <= nbr_circles; i = i+13) {

    // Function for spiral

    float ratio = i/(float)nbr_circles; // [1]
    float spiral_rad = ratio * outer_rad; // [1]
    float angle = i*angle_incr; // [1]
    float x = cx + cos(angle) * spiral_rad;// [1]
    float y = cy + sin(angle) * spiral_rad;// [1]

    // Making sure the starting point is > 0

    float prev_i = i-13;
    if (prev_i <= 0) {
      prev_i = prev_i + 13;
    }

    // Defining the previous point

    float prev_ratio = prev_i/(float)nbr_circles;
    float prev_spiral_rad = prev_ratio * outer_rad;
    float prev_angle = prev_i*angle_incr;
    float prev_x = cx + cos(prev_angle) * prev_spiral_rad;
    float prev_y = cy + sin(prev_angle) * prev_spiral_rad;

    // Defining 9 point between (x,y) and (prev_x, prev_y) with interpolation

    float ix = (0.90*prev_x)+(0.10*x);
    float iy = (0.90*prev_y)+(0.10*y);

    float jx = (0.80*prev_x)+(0.20*x);
    float jy = (0.80*prev_y)+(0.20*y);

    float kx = (0.70*prev_x)+(0.30*x);
    float ky = (0.70*prev_y)+(0.30*y);

    float lx = (0.60*prev_x)+(0.40*x);
    float ly = (0.60*prev_y)+(0.40*y);

    float mx = (x+prev_x)/2;
    float my = (y+prev_y)/2;

    float nx = (0.40*prev_x)+(0.60*x);
    float ny = (0.40*prev_y)+(0.60*y);

    float ox = (0.30*prev_x)+(0.70*x);
    float oy = (0.30*prev_y)+(0.70*y);

    float px = (0.20*prev_x)+(0.80*x);
    float py = (0.20*prev_y)+(0.80*y);

    float qx = (0.10*prev_x)+(0.90*x);
    float qy = (0.10*prev_y)+(0.90*y);

    // Perform offsetting

    float offset_angle = atan((prev_y-y)/(x-prev_x));  // Calculate angle of line 
    if (prev_x > x) {
      offset_angle = offset_angle + PI;
    }

    // Alternating symmetry: if i is uneven --> invert en mirror points of even. 

    if (i %2==0)  // Even
    { 
      // Draw points with same parallel and perpendicular offset as the interactive triangle

      ix = ix + ( Perp_Offset[9][1])*sin(offset_angle)*ratio - ( -Perp_Offset[9][0]) *cos(offset_angle)*ratio;    //E (to know which point should be which in the symmetry)
      iy = iy + ( Perp_Offset[9][1])*cos(offset_angle)*ratio + ( -Perp_Offset[9][0]) *sin(offset_angle)*ratio;

      jx = jx + ( Perp_Offset[8][1])*sin(offset_angle)*ratio - ( -Perp_Offset[8][0]) *cos(offset_angle)*ratio;    //F
      jy = jy + ( Perp_Offset[8][1])*cos(offset_angle)*ratio + ( -Perp_Offset[8][0]) *sin(offset_angle)*ratio;

      kx = kx + ( Perp_Offset[7][1])*sin(offset_angle)*ratio - ( -Perp_Offset[7][0]) *cos(offset_angle)*ratio;    //G
      ky = ky + ( Perp_Offset[7][1])*cos(offset_angle)*ratio + ( -Perp_Offset[7][0]) *sin(offset_angle)*ratio;

      lx = lx + ( Perp_Offset[6][1])*sin(offset_angle)*ratio - ( -Perp_Offset[6][0]) *cos(offset_angle)*ratio;    //H
      ly = ly + ( Perp_Offset[6][1])*cos(offset_angle)*ratio + ( -Perp_Offset[6][0]) *sin(offset_angle)*ratio;

      mx = mx + ( Perp_Offset[5][1])*sin(offset_angle)*ratio - ( -Perp_Offset[5][0]) *cos(offset_angle)*ratio;    //I
      my = my + ( Perp_Offset[5][1])*cos(offset_angle)*ratio + ( -Perp_Offset[5][0]) *sin(offset_angle)*ratio;

      nx = nx + ( Perp_Offset[4][1])*sin(offset_angle)*ratio - ( -Perp_Offset[4][0]) *cos(offset_angle)*ratio;    //J
      ny = ny + ( Perp_Offset[4][1])*cos(offset_angle)*ratio + ( -Perp_Offset[4][0]) *sin(offset_angle)*ratio;

      ox = ox + ( Perp_Offset[3][1])*sin(offset_angle)*ratio - ( -Perp_Offset[3][0]) *cos(offset_angle)*ratio;    //K
      oy = oy + ( Perp_Offset[3][1])*cos(offset_angle)*ratio + ( -Perp_Offset[3][0]) *sin(offset_angle)*ratio;

      px = px + ( Perp_Offset[2][1])*sin(offset_angle)*ratio - ( -Perp_Offset[2][0]) *cos(offset_angle)*ratio;    //L
      py = py + ( Perp_Offset[2][1])*cos(offset_angle)*ratio + ( -Perp_Offset[2][0]) *sin(offset_angle)*ratio;

      qx = qx + ( Perp_Offset[1][1])*sin(offset_angle)*ratio - ( -Perp_Offset[1][0]) *cos(offset_angle)*ratio;    //M
      qy = qy + ( Perp_Offset[1][1])*cos(offset_angle)*ratio + ( -Perp_Offset[1][0]) *sin(offset_angle)*ratio;

      // Draw points and connect with line

      curveVertex(prev_x, prev_y);
      curveVertex(prev_x, prev_y);
      curveVertex(ix, iy);
      curveVertex(jx, jy);
      curveVertex(kx, ky);
      curveVertex(lx, ly);
      curveVertex(mx, my);
      curveVertex(nx, ny);
      curveVertex(ox, oy);
      curveVertex(px, py);
      curveVertex(qx, qy);
      curveVertex(x, y);
      curveVertex(x, y);
      vertex(x, y);
    } else // Uneven
    { 
      // Draw points with same parallel and perpendicular offset as the interactive triangle 

      ix = ix + (- Perp_Offset[1][1])*sin(offset_angle)*ratio - ( Perp_Offset[1][0]) *cos(offset_angle)*ratio;    // -M  (to know which point should be which in the symmetry)
      iy = iy + (- Perp_Offset[1][1])*cos(offset_angle)*ratio + ( Perp_Offset[1][0]) *sin(offset_angle)*ratio;

      jx = jx + (- Perp_Offset[2][1])*sin(offset_angle)*ratio - ( Perp_Offset[2][0]) *cos(offset_angle)*ratio;    // -L
      jy = jy + (- Perp_Offset[2][1])*cos(offset_angle)*ratio + ( Perp_Offset[2][0]) *sin(offset_angle)*ratio;

      kx = kx + (- Perp_Offset[3][1])*sin(offset_angle)*ratio - ( Perp_Offset[3][0]) *cos(offset_angle)*ratio;    // -K
      ky = ky + (- Perp_Offset[3][1])*cos(offset_angle)*ratio + ( Perp_Offset[3][0]) *sin(offset_angle)*ratio;

      lx = lx + (- Perp_Offset[4][1])*sin(offset_angle)*ratio - ( Perp_Offset[4][0]) *cos(offset_angle)*ratio;    // -J
      ly = ly + (- Perp_Offset[4][1])*cos(offset_angle)*ratio + ( Perp_Offset[4][0]) *sin(offset_angle)*ratio;

      mx = mx + (- Perp_Offset[5][1])*sin(offset_angle)*ratio - ( Perp_Offset[5][0]) *cos(offset_angle)*ratio;    // -I
      my = my + (- Perp_Offset[5][1])*cos(offset_angle)*ratio + ( Perp_Offset[5][0]) *sin(offset_angle)*ratio;

      nx = nx + (- Perp_Offset[6][1])*sin(offset_angle)*ratio - ( Perp_Offset[6][0]) *cos(offset_angle)*ratio;    // -H
      ny = ny + (- Perp_Offset[6][1])*cos(offset_angle)*ratio + ( Perp_Offset[6][0]) *sin(offset_angle)*ratio;

      ox = ox + (- Perp_Offset[7][1])*sin(offset_angle)*ratio - ( Perp_Offset[7][0]) *cos(offset_angle)*ratio;    // -G
      oy = oy + (- Perp_Offset[7][1])*cos(offset_angle)*ratio + ( Perp_Offset[7][0]) *sin(offset_angle)*ratio;

      px = px + (- Perp_Offset[8][1])*sin(offset_angle)*ratio - ( Perp_Offset[8][0]) *cos(offset_angle)*ratio;    // -F
      py = py + (- Perp_Offset[8][1])*cos(offset_angle)*ratio + ( Perp_Offset[8][0]) *sin(offset_angle)*ratio;

      qx = qx + (- Perp_Offset[9][1])*sin(offset_angle)*ratio - ( Perp_Offset[9][0]) *cos(offset_angle)*ratio;    // -E
      qy = qy + (- Perp_Offset[9][1])*cos(offset_angle)*ratio + ( Perp_Offset[9][0]) *sin(offset_angle)*ratio;

      curveVertex(prev_x, prev_y);
      curveVertex(prev_x, prev_y);
      curveVertex(ix, iy);
      curveVertex(jx, jy);
      curveVertex(kx, ky);
      curveVertex(lx, ly);
      curveVertex(mx, my);
      curveVertex(nx, ny);
      curveVertex(ox, oy);
      curveVertex(px, py);
      curveVertex(qx, qy);
      curveVertex(x, y);
      curveVertex(x, y);
      vertex(x, y);
    }
  } 
  endShape();
} 

void drawLineAB(int n) {
  beginShape();
  vertex(cx, cy);
  for (int i = n; i <= nbr_circles; i = i+21) {

    // Function for spiral

    float ratio = i/(float)nbr_circles; // [1]
    float spiral_rad = ratio * outer_rad; // [1]
    float angle = i*angle_incr; // [1]
    float x = cx + cos(angle) * spiral_rad;// [1]
    float y = cy + sin(angle) * spiral_rad;// [1]

    // Making sure the starting point is > 0

    float prev_i = i-21;
    if (prev_i <= 0) {
      prev_i = prev_i + 21;
    }

    // Defining the previous point

    float prev_ratio = prev_i/(float)nbr_circles;
    float prev_spiral_rad = prev_ratio * outer_rad;
    float prev_angle = prev_i*angle_incr;
    float prev_x = cx + cos(prev_angle) * prev_spiral_rad;
    float prev_y = cy + sin(prev_angle) * prev_spiral_rad;

    // Defining 9 point between (x,y) and (prev_x, prev_y) with interpolation

    float ix = (0.90*prev_x)+(0.10*x);
    float iy = (0.90*prev_y)+(0.10*y);

    float jx = (0.80*prev_x)+(0.20*x);
    float jy = (0.80*prev_y)+(0.20*y);

    float kx = (0.70*prev_x)+(0.30*x);
    float ky = (0.70*prev_y)+(0.30*y);

    float lx = (0.60*prev_x)+(0.40*x);
    float ly = (0.60*prev_y)+(0.40*y);

    float mx = (x+prev_x)/2;
    float my = (y+prev_y)/2;

    float nx = (0.40*prev_x)+(0.60*x);
    float ny = (0.40*prev_y)+(0.60*y);

    float ox = (0.30*prev_x)+(0.70*x);
    float oy = (0.30*prev_y)+(0.70*y);

    float px = (0.20*prev_x)+(0.80*x);
    float py = (0.20*prev_y)+(0.80*y);

    float qx = (0.10*prev_x)+(0.90*x);
    float qy = (0.10*prev_y)+(0.90*y);

    // Perform offsetting

    float offset_angle = atan((prev_y-y)/(x-prev_x));  // Calculate angle of line 
    if (prev_x > x) {
      offset_angle = offset_angle + PI;
    }

    // Find coordinates for interactive triangle

    if ((i == 85) || (i == 72) || (i == 93)) {
      coordinates[i]= new PVector(x, y);
    }

    // Alternating symmetry: if i is uneven --> invert en mirror points of even. 

    if (i %2==0) // even
    {
      // Draw points with same parallel and perpendicular offset as the interactive triangle

      ix = ix + ( Perp_Offset[1][1])*sin(offset_angle)*ratio - ( Perp_Offset[1][0]) *cos(offset_angle)*ratio;    // M
      iy = iy + ( Perp_Offset[1][1])*cos(offset_angle)*ratio + ( Perp_Offset[1][0]) *sin(offset_angle)*ratio;

      jx = jx + ( Perp_Offset[2][1])*sin(offset_angle)*ratio - ( Perp_Offset[2][0]) *cos(offset_angle)*ratio;    // L
      jy = jy + ( Perp_Offset[2][1])*cos(offset_angle)*ratio + ( Perp_Offset[2][0]) *sin(offset_angle)*ratio;

      kx = kx + ( Perp_Offset[3][1])*sin(offset_angle)*ratio - ( Perp_Offset[3][0]) *cos(offset_angle)*ratio;    // K
      ky = ky + ( Perp_Offset[3][1])*cos(offset_angle)*ratio + ( Perp_Offset[3][0]) *sin(offset_angle)*ratio;

      lx = lx + ( Perp_Offset[4][1])*sin(offset_angle)*ratio - ( Perp_Offset[4][0]) *cos(offset_angle)*ratio;    // J
      ly = ly + ( Perp_Offset[4][1])*cos(offset_angle)*ratio + ( Perp_Offset[4][0]) *sin(offset_angle)*ratio;

      mx = mx + ( Perp_Offset[5][1])*sin(offset_angle)*ratio - ( Perp_Offset[5][0]) *cos(offset_angle)*ratio;    // I
      my = my + ( Perp_Offset[5][1])*cos(offset_angle)*ratio + ( Perp_Offset[5][0]) *sin(offset_angle)*ratio;

      nx = nx + ( Perp_Offset[6][1])*sin(offset_angle)*ratio - ( Perp_Offset[6][0]) *cos(offset_angle)*ratio;    // H
      ny = ny + ( Perp_Offset[6][1])*cos(offset_angle)*ratio + ( Perp_Offset[6][0]) *sin(offset_angle)*ratio;

      ox = ox + ( Perp_Offset[7][1])*sin(offset_angle)*ratio - ( Perp_Offset[7][0]) *cos(offset_angle)*ratio;    // G
      oy = oy + ( Perp_Offset[7][1])*cos(offset_angle)*ratio + ( Perp_Offset[7][0]) *sin(offset_angle)*ratio;

      px = px + ( Perp_Offset[8][1])*sin(offset_angle)*ratio - ( Perp_Offset[8][0]) *cos(offset_angle)*ratio;    // F
      py = py + ( Perp_Offset[8][1])*cos(offset_angle)*ratio + ( Perp_Offset[8][0]) *sin(offset_angle)*ratio;

      qx = qx + ( Perp_Offset[9][1])*sin(offset_angle)*ratio - ( Perp_Offset[9][0]) *cos(offset_angle)*ratio;    // E 
      qy = qy + ( Perp_Offset[9][1])*cos(offset_angle)*ratio + ( Perp_Offset[9][0]) *sin(offset_angle)*ratio;

      // Draw points and connect with line

      curveVertex(prev_x, prev_y);
      curveVertex(prev_x, prev_y);
      curveVertex(ix, iy);
      curveVertex(jx, jy);
      curveVertex(kx, ky);
      curveVertex(lx, ly);
      curveVertex(mx, my);
      curveVertex(nx, ny);
      curveVertex(ox, oy);
      curveVertex(px, py);
      curveVertex(qx, qy);
      curveVertex(x, y);
      curveVertex(x, y);
      vertex(x, y);
    } else // Uneven
    {
      // Draw points with same parallel and perpendicular offset as the interactive triangle     

      ix = ix + ( -Perp_Offset[9][1])*sin(offset_angle)*ratio - ( -Perp_Offset[9][0]) *cos(offset_angle)*ratio;    // -E
      iy = iy + ( -Perp_Offset[9][1])*cos(offset_angle)*ratio + ( -Perp_Offset[9][0]) *sin(offset_angle)*ratio;

      jx = jx + ( -Perp_Offset[8][1])*sin(offset_angle)*ratio - ( -Perp_Offset[8][0]) *cos(offset_angle)*ratio;    // -F
      jy = jy + ( -Perp_Offset[8][1])*cos(offset_angle)*ratio + ( -Perp_Offset[8][0]) *sin(offset_angle)*ratio;

      kx = kx + ( -Perp_Offset[7][1])*sin(offset_angle)*ratio - ( -Perp_Offset[7][0]) *cos(offset_angle)*ratio;    // -G
      ky = ky + ( -Perp_Offset[7][1])*cos(offset_angle)*ratio + ( -Perp_Offset[7][0]) *sin(offset_angle)*ratio;

      lx = lx + ( -Perp_Offset[6][1])*sin(offset_angle)*ratio - ( -Perp_Offset[6][0]) *cos(offset_angle)*ratio;    // -H
      ly = ly + ( -Perp_Offset[6][1])*cos(offset_angle)*ratio + ( -Perp_Offset[6][0]) *sin(offset_angle)*ratio;

      mx = mx + ( -Perp_Offset[5][1])*sin(offset_angle)*ratio - ( -Perp_Offset[5][0]) *cos(offset_angle)*ratio;    // -I
      my = my + ( -Perp_Offset[5][1])*cos(offset_angle)*ratio + ( -Perp_Offset[5][0]) *sin(offset_angle)*ratio;

      nx = nx + ( -Perp_Offset[4][1])*sin(offset_angle)*ratio - ( -Perp_Offset[4][0]) *cos(offset_angle)*ratio;    // -J
      ny = ny + ( -Perp_Offset[4][1])*cos(offset_angle)*ratio + ( -Perp_Offset[4][0]) *sin(offset_angle)*ratio;

      ox = ox + ( -Perp_Offset[3][1])*sin(offset_angle)*ratio - ( -Perp_Offset[3][0]) *cos(offset_angle)*ratio;    // -K
      oy = oy + ( -Perp_Offset[3][1])*cos(offset_angle)*ratio + ( -Perp_Offset[3][0]) *sin(offset_angle)*ratio;

      px = px + ( -Perp_Offset[2][1])*sin(offset_angle)*ratio - ( -Perp_Offset[2][0]) *cos(offset_angle)*ratio;    // -L
      py = py + ( -Perp_Offset[2][1])*cos(offset_angle)*ratio + ( -Perp_Offset[2][0]) *sin(offset_angle)*ratio;

      qx = qx + ( -Perp_Offset[1][1])*sin(offset_angle)*ratio - ( -Perp_Offset[1][0]) *cos(offset_angle)*ratio;    // -M
      qy = qy + ( -Perp_Offset[1][1])*cos(offset_angle)*ratio + ( -Perp_Offset[1][0]) *sin(offset_angle)*ratio;

      // Draw points and connect with line

      curveVertex(prev_x, prev_y);
      curveVertex(prev_x, prev_y);
      curveVertex(ix, iy);
      curveVertex(jx, jy);
      curveVertex(kx, ky);
      curveVertex(lx, ly);
      curveVertex(mx, my);
      curveVertex(nx, ny);
      curveVertex(ox, oy);
      curveVertex(px, py);
      curveVertex(qx, qy);
      curveVertex(x, y);
      curveVertex(x, y);
      vertex(x, y);
    }
  } 
  endShape();
}