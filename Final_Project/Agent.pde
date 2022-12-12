class Agent{
  PVector pos;
  PVector goal;
  PVector movement;
  color pixelColor;
  color goalPixelColor;
  float[] rot;
  float[] trans;
  
  Agent(float[] pRot, float[] pTrans,PVector pPos, color pColor){
    pos = pPos;
    pixelColor = pColor;
    goal = pos;
    rot = pRot;
    trans = pTrans;
  }
  
  public void move(){
    pos.add(movement);
    pixelColor = lerpColor(pixelColor, goalPixelColor, 0.5f);
  }
  
  public void display(){
    stroke(pixelColor);  
    point(pos.x,pos.y,pos.z);
  }
  
  public void updateGoal(float[] pRot, float[] pTrans,PVector pGoal,color pColor){
    rot = pRot;
    trans = pTrans;
    goalPixelColor = pColor;
    goal = PVector.add(rotate(pGoal,rot),new PVector(trans[0],trans[1],trans[2]));
    movement = (PVector.sub(goal,pos)).mult(0.1f);
  }
  
  PVector rotate(PVector v, float[] rot){
      v = rotZ(v,rot[2]);
      v = rotY(v,rot[1]);
       v = rotX(v,rot[0]);
       
       
       return v;
  }
  
  PVector rotX(PVector v, float rot){
    var sinTheta = sin(rot);
    var cosTheta = cos(rot);
    var y = v.y;
    var z = v.z;
    v.y = y * cosTheta - z * sinTheta;
    v.z = z * cosTheta + y * sinTheta;
    return v;
  }
  
  PVector rotY(PVector v, float rot){
    var sinTheta = sin(rot);
    var cosTheta = cos(rot);
    var x = v.x;
    var z = v.z;
    v.x = x * cosTheta + z * sinTheta;
    v.z = z * cosTheta - x * sinTheta;
    return v;
  }
       
  PVector rotZ(PVector v, float rot){
    var sinTheta = sin(rot);
    var cosTheta = cos(rot);
    var x = v.x;
    var y = v.y;
    v.x = x * cosTheta - y * sinTheta;
    v.y = y * cosTheta + x * sinTheta;
    return v;
  }
}
