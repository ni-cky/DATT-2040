/** 
Source: https://discourse.processing.org/t/2d-matrix-reverse-screenx-screeny-function-class/10929
Class to keep track of 2D matrix transformations
   (to reverse-transform screen coordinates to matrix coordinates)

    To keep track of matrix transformations:
      Instead of:     Use:
      --------------  -----------------------------
      pushMatrix()    MatrixTracker2D.push()
      popMatrix()     MatrixTracker2D.pop()
      resetMatrix()   MatrixTracker2D.reset()
      translate(x,y)  MatrixTracker2D.move(x,y)
      rotate(angle)   MatrixTracker2D.turn(angle)
      
    Where "MatrixTracker2D" is an object of that type.

    To get a "matrix position" from a screen position (reverse of screenX / screenY):
  
      MatrixTracker2D.posX(x,y)
      MatrixTracker2D.posY(x,y)   where x,y = screen coordinates

    To get the angle between a screen position and a matrix position
    relative to the matrix X-axis, use:

      MatrixTracker2D.getAngle(sx, sy, mx, my)

    where:
      sx, sy is a screen position, and
      mx, my is a position in the current matrix


    2019.05.05 raron 
    (No guarantee that it actually works as intended)
*/

class MatrixTracker2D {
  int level = 0;
  // Processing allows a maximum of 32 pushMatrix()'es afaik
  // I'm including the "base" matrix here, totalling 33.
  final int max = 33;
  FloatList txList;
  FloatList tyList;
  FloatList angList;
  
  MatrixTracker2D() {
    // pre-allocating max matrix transformations
    txList = new FloatList(max);
    tyList = new FloatList(max);
    angList = new FloatList(max);
    // initialize one entry for the "base" matrix (assumed reset)
    txList.append(0);
    tyList.append(0);
    angList.append(0);
    level = txList.size(); // is 1 at instantiation
  }
  
  // Make space for new matrix transform data
  void push() {
    if (level>0 && level<max) {
      int i = level-1;
      txList.append(txList.get(i));
      tyList.append(tyList.get(i));
      angList.append(angList.get(i));
      level = txList.size();
      pushMatrix();
    }
  }
  
  // Translate matrix
  void move(float x, float y) {
    if (level > 0) {
      int i = level-1;
      float tempX = txList.get(i);
      float tempY = tyList.get(i);
      float ang = angList.get(i);
      txList.set(i, tempX + x*cos(ang) + y*cos(ang+PI/2));
      tyList.set(i, tempY + x*sin(ang) + y*sin(ang+PI/2));
      translate(x,y);
    }
  }
  
  // Rotate matrix
  void turn(float angle) {
    if (level > 0) {
      int i = level-1;
      angList.set(i, angList.get(i) + angle);
      rotate(angle);
    }
  }

  void reset() {
    txList.set(level-1, 0);
    tyList.set(level-1, 0);
    angList.set(level-1, 0);
    resetMatrix();
  }
  
  // remove last matrix and data
  void pop() {
    if (level>0) {
      txList.remove(level-1);
      tyList.remove(level-1);
      angList.remove(level-1);
      level = txList.size();
      popMatrix();
    }
  }

  // Get matrix X position from screen position
  // (reverse screenX)
  float posX(float x, float y) {
    int i = level-1;
    float tx = txList.get(i);
    float ty = tyList.get(i);
    float ang = atan2(y-ty, x-tx) - angList.get(i);
    float pDist = sqrt(pow(x-txList.get(i),2) + pow((y-tyList.get(i)),2));
    float mx = pDist * cos(ang);
    return mx;
  }
  
  // Get matrix Y position from screen position
  // (reverse screenY)
  float posY(float x, float y) {
    int i = level-1;
    float tx = txList.get(i);
    float ty = tyList.get(i);
    float ang = atan2(y-ty, x-tx) - angList.get(i);
    float pDist = sqrt(pow(x-txList.get(i),2) + pow((y-tyList.get(i)),2));
    float my = pDist * sin(ang);
    return my;
  }
  
  // Angle of line between a screen position and a matrix position
  // relative to the matrix X-axis.
  float getAngle(float sx, float sy, float mx, float my) {
    int i = level-1;
    float tx = screenX(mx, my);
    float ty = screenY(mx, my);
    float ang = atan2(sy-ty, sx-tx) - angList.get(i);
    // Also works (slower?)
    // float tx = posX(sx, sy);
    // float ty = posY(sx, sy);
    // float ang = atan2(ty-my, tx-mx);
    return ang;
  }
  
  
  
}
