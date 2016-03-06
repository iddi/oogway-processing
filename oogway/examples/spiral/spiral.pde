import nl.tue.id.oogway.*;

Oogway o;

void setup() {
  size(400, 400);
  o= new Oogway(this);
  f(.01, 89.5, .01, 184);
}

void f(float dist, float angle, float incr, int segs /*(number of segments)*/)
{
  //start in the center of a square view-space, facing east
  //repeat segs times:
  for (int i=0; i<segs; i++) {
    //go dist * (60% the view-space width) in the current direction
    o.forward(dist*.6*(width-100));

    //turn angle degrees clockwise (to your right)
    o.right(angle);

    //increment dist by incr
    dist += incr;
  }
}