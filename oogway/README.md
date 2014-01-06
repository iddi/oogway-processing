
---

* Po: _Okay. So like, Oogway was just a crazy old turtle after all?_

* Shifu: _No. Oogway was wiser than us all._

---

Oogway, making ideas from the Turtle graphics available in Processing. Oogway is named after the master in the Kung Fu Panda (http://kungfupanda.wikia.com/wiki/Oogway)

Oogway is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Oogway is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
 along with Oogway.  If not, see <http://www.gnu.org/licenses/>.
 
---
# Oogway Motion
---

## Motion and Draw

### forward | fd
    forward(distance)
    fd(distance)
Parameters:	
* distance - float

Move the oogway forward over the specified distance, in the direction the oogway is heading.

### backward | bk | back
    back(distance)
    bk(distance)
    backward(distance)
Parameters:	
* distance - float

Move the oogway backward by distance, opposite to the direction the oogway is headed. Do not change the oogway's heading.

### right | rt
	right(angle)
	rt(angle)
Parameters:	
* angle - float

Turn the oogway right by angle (degrees).

### left | lt
	left(angle)
	lt(angle)
Parameters:	
* angle - float

Turn the oogway left by angle (degrees).

### shift
    shift(absoluteAngle, distance)
Parameters:
* absoluteAngle - float, in degrees
* distance - float

Shift the oogway towards an absoluteAngle, over the specified distance, but keeping the heading direction unchanged, without leaving traces, no matter wheter the pen is up or down.. Use the absolute angle with caution, since the reflection commands will have no effect on the absolute angles.

### shiftForward
    shiftForward(distance)
Parameters:
* distance - float

Shift the oogway forward over a specified distance, in the direction the oogway is heading, without leaving traces, no matter wheter the pen is up or down.

### shiftBackward
    shiftBackward(distance)
Parameters:
* distance - float

Shift the oogway backward over a specified distance, opposite to the the direction the oogway is heading, without leaving a trace, no matter whether the pen is up or down. It keeps the oogway's heading direction.


### shiftLeft
    shiftLeft(angle, distance)
Parameters:
* angle - float, in degrees
* distance - float 

Shift the oogway towards a relative angle at the left, over the specified distance, but keeping the heading direction unchanged, without leaving a trace, no matter whether the pen is up or down.. Use the absolute angle with caution, since the reflection commands will have no effect on the absolute angles.

### shiftRight
    shiftRight(angle, distance)
Parameters
* angle - float, in degrees
* distance - float 

Shift the oogway towards a relative angle at the right, over the specified distance, but keeping the heading direction unchanged, without leaving a trace, no matter whether the pen is up or down.. Use the absolute angle with caution, since the reflection commands will have no effect on the absolute angles.


### setHeading
    setHeading(to_angle)
Parameters:
* to_angle - float, in degrees.

Set the orientation of the turtle to to_angle. 

### setPos | setPosition
    setPos(x, y)
	setPosition(x, y)
Parameters:
* x, y - float. Absolute position to move to.

Move the oogway to an absolute position. No trace will be left, no matter whether the pen is down or up.

### mirrorPosition
    mirrorPosition(x1, y1, x2, y2)
Parameters
   x1, y1, x2, y2 - float, two points that defines a line

Mirror the oogway's position against the given line, keeping the heading direction unchanged, without leaving a trace,  no matter whether the pen is down or up.
   


### home
    home()
Move oogway to the origin, and set its heading to the right (west);

### stamp
    stamp()
	stamp(size)
	stamp(width, height)
Parameters:
* size - float. The ooway will be stamped in a square bounding box with the specified side size.
* width, height - float. The ooway will be stamped in a bounding box with the specified width and height.

Stamp a copy of the oogway shape onto the canvas at the current oogway position, along the heading orientation. By default an arrow is stamped, either filled or not filled, depending on the Processing graphics environment. An SVG shape can be stamped instead, using setStemp(). 

### setStamp
    setStamp(svgfile)
Parameters:
* svgfile - fine name of the SVG file

Instead of the default arrow, the shape defined in the SVG file can be used as stamp.

## Tell oogway's state

### xcor
    xcor()
Return the oogway's x coordinate.

### ycor
    ycor()
Return the oogway's x coordinate.

### heading
    heading()
Return the oogway's current heading angle, in degrees.

### towards
    towards(x, y)
   
Parameters:
* x, y - float.

Return the angle of the line from the oogway's position to the position specified by (x,y).

### distance()
    distance(x, y)
Parameters:
* x, y - float.

Return the distance from the oogway's position to the position specified by (x, y).

## Change oogway's trace
The following commands shall be always used in pairs. "begin" a trace will change the oogway's trace left on the canvas until "end" the trace. "begin"ing a trace will "end" the trace that has been "begin"ed, if it is not "end"ed. "end"ing a trace will change the trace to normal strait and solid lines.

### beginDash and endDash
    beginDash(pattern)
	beginDash()
	endDash()
Parameters:
* pattern - float[], dash pattern.

The dash "pattern" giving lengths of dashes and gaps in pixels; an array with values {10, 3, 9, 4} will draw a line with a 10-pixel dash, 3-pixel gap, 9-pixel dash, * and 4-pixel gap. if the array has an odd number of entries, the values
are recycled, so an array of {5, 3, 2} will draw a line with a 5-pixel dash, 3-pixel gap, 2-pixel dash, 5-pixel gap, 3-pixel dash, and 2-pixel gap, then repeat. If no pattern is given, {10, 5} is used by default.

### beginSpline and endSpline
    beginSpline(x, y)
	beginSpline()
	endSpline(x,y)
	endSpline()
Parameters
* x, y - float, coordinates of extra control points

The current position of the oogway, and all the new positions reached by `forward()` and b`ackward()` (not including `setPositions()`) between `beginSpline()` and `endSpline()`, will be used to create a spline curve as the trace on the canvas. The starting position and the ending position are repeated as control points (which is a common practice), unless x and y parameters are used.

### beginPath and endPath
    beginPath(svgfile)
	beginPath()
	endPath()
Parameters
* svgfile - String, file name of the SVG file

`beginPath(svgfile)` will load a path/curve from the specified SVG file as the trace for every `forward()` and `backward()` until `endPath()`. `beginPath()` without the parameter will load again the latest SVG file been loaded. If there is no previous SVG file been loaded, `beginPath()` has no effect but the oogway will leave a straght line on canvas instead.

Oogway supports SVG files created with Inkscape and Adobe Illustrator. The SVG file should contain simply one path or polyline that is created use multiple vertices. If more than one paths are included in the SVG file, only the first one will be loaded. 

The starting vertex and the ending vertex of the path shall differ, or a straight line trace will be left on canvas instead.

### Reflection of the trace
    beginReflection()
	endReflection()
	isReflecting()

All the traces left by the oogway on the canvas between beginReflection() and endReflection will be reflected. Technically , it swaps `left()` and `right()` between `beginReflection()` and `endReflection()`, which can also be achieved by simply multiplying -1 with the angles of `left()` and `right()`. But it also affects the paths that are loaded with the `beginPath(svgfile)` method.

`beginReflection()` and `endReflection()` can be nested. `isReflecting()` returns `ture` if the current trace is reflected, otherwise returns `false`.

---
# Pen control
---
## Drawing control
### penDown | pd | down
    penDown()
	pd()
	down()

Put the pen down for drawing when moving.

### penUp | pu | up
    penUp()
    pu()
    up()

Pull the pen up from drawing when moving.

### penSize
    penSize()

Retures the size of the pen.

### setPenSize
    setPenSize(size)
Parameters:
* size - float.

Set the size of the pen. It changes the thickness of the trace. 

### isDown
    isDown()
Return `true` if pen is down, `false` if it is up.

## Color contol
### setPenColor
    setPenColor(gray)
	setPenColor(color)
	setPenColor(red, green, blue)
Parameters:
* gray - int or float between 0 and 255: specifies a value between white and black
* red, gree, blue - int or float between 0 and 255.  RGB color.
* color -  any value of the color datatype in Processing

###  penColor
    penColor()

Get the color of the pen; retures value of the color datatype in Processing.

---
# Oogway state
---

### pushState
    pushState()

push the state of the oogway into a stack. The state inclues current position, heading, pen size, pen color, whether the pen is up or down, whether reflection is on, as well as other properties.

### popState
    popState()
Pops the latest state of the oogway out of the stack, resets oogway according to the this state.

### remember
    remember(key)
Parameters:
* key - String, char or int. 

Saves the current state of the oogway into a hash table using the `key`. 

### recall
    recall(key)
parameters:
* key - String, char or int. 

Use the `key` to find the saved state, and restore the state of oogway accordingly.

### clone
    clone()

Create and return a clone of the oogway with the same state. The state inclues current position, heading, pen size, pen color, whether the pen is up or down, whether reflection is on, as well as other properties.

![Oogway](http://images2.wikia.nocookie.net/__cb20120901174346/kungfupanda/images/2/2e/Oogway-white.png)

