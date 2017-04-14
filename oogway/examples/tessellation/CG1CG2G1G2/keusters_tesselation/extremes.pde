//these two functions search for the points with the highest or lowest X and Y

float highestValues(int C) { //For X, C = 0, for Y, C = 1
  float currentMax = 0;
  for (int j = 0; j < 4; j++) { //check all (four) lines
    for (int i = 0; i < count[j]+1; i++) { //check all points in line j
      if (allPoints[j][i][C] > currentMax) { //if point checked > saved value, save the current value
        currentMax = allPoints[j][i][C];
      }
    }
    if (pointE[C] > currentMax) { //also check pointE (E)
      currentMax = pointE[C];
    }
  }
  return currentMax;
}

float lowestValues(int C) { 
  float currentMin = allPoints[0][0][C];
  for (int j = 0; j < 4; j++) {
    for (int i = 0; i < count[j]+1; i++) {
      if (allPoints[j][i][C] < currentMin) {
        currentMin = allPoints[j][i][C];
      }
    }
    if (pointE[C] < currentMin) {
      currentMin = pointE[C];
    }
  }
  return currentMin;
}