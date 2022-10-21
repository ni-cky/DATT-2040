import peasy.*;
PeasyCam cam;
void setup() {
  size(600, 600, P3D);
    cam = new PeasyCam(this, 500);
}

void draw() {
  background(0);
  noFill();
  stroke(255);
  drawSquare(0,0,0, 100,2);
  sphere(20);
}

void drawSquare(float x, float y, float z, float sideLength, int rec){
  x = x-sideLength/2.;
  z = z-sideLength/2.;
  drawLine(x,y,z,x,y,z+sideLength, rec-1);
  drawLine(x,y,z+sideLength,x+sideLength,y,z+sideLength, rec-1);
  drawLine(x+sideLength,y,z+sideLength,x+sideLength,y,z, rec-1);
  drawLine(x+sideLength,y,z,x,y,z, rec-1);
}

void drawLine(float x1, float y1, float z1, float x2, float y2, float z2, int rec){
  PVector line = PVector.sub(new PVector(x2,y2,z2),new PVector(x1,y1,z1));
  float stepSize = line.mag()/10f;
  line.normalize();
  for(float i = 1; i <= 10; i++){
    float x = x1 + (line.x * stepSize)*i;
    float y = y1 + (line.y * stepSize)*i;
    float z = z1 + (line.z * stepSize)*i;
    pushMatrix();
    translate(x,y,z);
    if(rec > 0)
      drawSquare(0,0,0,stepSize,rec);
    else
      sphere(1);
    popMatrix();
  }
}
