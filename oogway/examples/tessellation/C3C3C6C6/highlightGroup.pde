
void highlightGroup(float scale){
  o.shift(180+vHeading, vDistance);
  o.shift(hHeading, hDistance);
  o.setPenColor(0,0,255);
  groupPositions(scale);
}
