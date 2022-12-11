int branches = 6;
float radius = 200f;
int recursions = 5;
int maxBranches = 16;
int randomBranches;
int intersectionBranches;
float angle; 

void setup(){
 size(420,420); 
 generateValues();
}

void generateValues(){
  branches = (int)random(4,16);
  intersectionBranches = (int)random(maxBranches);
 float range = 0.6;
 angle = random(HALF_PI/2-range,HALF_PI/2+range);
}

void mousePressed(){
  generateValues();
}

void draw(){
  background(0);
  
  for(int i = 0; i < branches;i++){
    
    pushMatrix();
    translate(width/2,height/2);
    rotate(i*TWO_PI/branches);
    drawBranch(2);
    popMatrix();
  }
}

void drawBranch(int i){
  if(i >= recursions)
    return;
  stroke(255);
  line(0,0,0,radius/i);
  
  for(int intersection = 0; intersection < intersectionBranches; intersection++){
    pushMatrix();
    translate(0,(radius/i)/(intersection+1));
    rotate(angle);
    i++;
    drawBranch(i);
    rotate(-angle*2);
    drawBranch(i);
    popMatrix();
  }
  
}
