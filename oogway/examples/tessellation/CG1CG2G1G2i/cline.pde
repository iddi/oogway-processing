
void cline(float x1, float y1, float x2, float y2, String svg){
  o.pushState();
  
  float mx = (x1 + x2)/2;
  float my = (y1 + y2)/2;
  
  o.setPosition(x1, y1);
  float d = o.distance(mx, my);
  o.setHeading(o.towards(mx, my));
  o.pathForward(d, svg);
  
  o.setPosition(x2, y2);
  o.setHeading(o.towards(mx, my));
  o.pathForward(d, svg);  
 
  o.popState();
  
}
