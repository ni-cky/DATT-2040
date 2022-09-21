//How to use:
//Click a few times to generatge different scatters of agents, to fill the area more quickly

PVector[] pos;
PVector[] acc;

int num = 255;
int speed = 2;

//Toggle scaling translucency of sqares, relating to their size
boolean translucent = true;
//Toggle if the centre should be filled or not
boolean grid = true;

void setup(){
  size(700,700);
  pos = new PVector[num];
  acc = new PVector[num];
  
  background(0);
  rectMode(CENTER);
  
  //populate
  for(int i = 0; i < num; i++){
   pos[i] = new PVector(random(width),random(height),random(20,70));
   acc[i] = new PVector(random(-speed,speed),random(-speed,speed),0);
  }
}

void draw(){

  
  for(int i = 0; i < num; i++){
    pos[i].add(acc[i]);
  PVector prevAcc = new PVector(acc[i].x,acc[i].y,acc[i].z);
  
  if(pos[i].x >= width-(pos[i].z/2) || pos[i].x <= (pos[i].z/2)){
   pos[i].sub(acc[i]);
   acc[i].x = acc[i].x * -1;
   acc[i].rotate(random(-HALF_PI/2,HALF_PI/2));
   pos[i].add(acc[i]);
  }
  if(pos[i].y >= height-(pos[i].z/2) || pos[i].y <= (pos[i].z/2)){
   pos[i].sub(acc[i]);
   acc[i].y = acc[i].y * -1;
   acc[i].rotate(random(-HALF_PI/2,HALF_PI/2));
   pos[i].add(acc[i]);
  }
  if(grid)
  if(((pos[i].x <= width/2-(pos[i].z/2)) && (pos[i].y <= height/2-(pos[i].z/2))) || (pos[i].x >= width/2+(pos[i].z/2)) && (pos[i].y >= height/2+(pos[i].z/2))){
    pos[i].sub(acc[i]);
    acc[i].x = acc[i].x * -1;
   acc[i].y = acc[i].y * -1;
   acc[i].rotate(random(-HALF_PI/2,HALF_PI/2));
   pos[i].add(acc[i]);
  }
  
  PVector postAcc = new PVector(acc[i].x,acc[i].y,acc[i].z);;
  if(prevAcc.x != postAcc.x || prevAcc.y != postAcc.y){
    PVector cross = prevAcc.cross(postAcc);
    float tran = translucent ? cross.mag()*cross.mag() : 0;
    stroke(0,255-tran);
    PVector colorBase = new PVector((i%51*5),-i%51*5,-i%51*5);
    PVector colorAdd = new PVector(0,255,255);
    colorBase.add(colorAdd);
    fill(colorBase.x,colorBase.y,colorBase.z,255-tran);
    //fill(i*5,255-i*5,255-i*5);
    rect(pos[i].x,pos[i].y,cross.mag()*cross.mag()*cross.mag(),cross.mag()*cross.mag()*cross.mag());
  }
  
  stroke(0,50);
  fill(255,10);
  //ellipse(pos[i].x,pos[i].y,pos[i].z,pos[i].z);
  }
}

void mousePressed(){
  for(int i = 0; i < num; i++){
   pos[i] = new PVector(random(width),random(height),random(20,70));
   acc[i] = new PVector(random(-speed,speed),random(-speed,speed),0);
  }
}
