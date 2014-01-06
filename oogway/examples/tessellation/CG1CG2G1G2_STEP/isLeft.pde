/**
 *  Line is (x1,y1) to (x2,y2), point is (x3,y3).
 *
 *  Find which side of a line a point is on. This can be done by assuming that 
 *  the line has a direction, pointing from its start to its end point. 
 *  a negative value ( < 0 ) if the point is "to the right" of the line, 
 *  zero ( == 0 ) if the point is on the line and a positive value ( > 0 ) if it's on "the left".
*/
boolean isLeft ( float x1, float y1, float x2, float y2, float x3, float y3 )
{
    return (x2 - x1) * (y3 - y1) - (y2 - y1) * (x3 - x1) > 0;   
} 


boolean isRight ( float x1, float y1, float x2, float y2, float x3, float y3 )
{
    return (x2 - x1) * (y3 - y1) - (y2 - y1) * (x3 - x1) < 0;   
} 

