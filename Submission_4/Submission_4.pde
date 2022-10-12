Snek[] sneks;
int num = 10;

void setup(){
 size(500,500); 
 
 sneks = new Snek[num];
 for(int i = 0; i < num; i++){
   PVector pos = new PVector(random(width), random(height));
    
   PVector speed = new PVector(1,1,0); 
   sneks[i] = new Snek(i,pos,speed, 50);
 }
}

void draw(){
  background(0);
  for(Snek s : sneks){
    s.move();
    s.draw();
  }
}

class Snek{
    int id;
    PVector pos;
    PVector speed;
    PVector limSpeed;
    PVector acc;
    
    float rotateSpeed = 0.6f;
    
    float magnitudeLimit = 0.001;
    
    float personalSpace;
    
    Snek(int pId, PVector pPos, PVector pSpeed, float pSpace){
      id = pId;
      pos = pPos;
      speed = pSpeed;
      speed.limit(magnitudeLimit);
      limSpeed = pSpeed;
      limSpeed.limit(magnitudeLimit);
      personalSpace = pSpace;
    }
    
    void move(){
      
      
      pos.x = pos.x + speed.x;
      if(id == 0)
        println(pos.x + "+" + speed.x+"="+(pos.x+speed.x));
      pos.y = pos.y + speed.y;
   
      /*if(pos.x +personalSpace/2 > width){
        pos.x = width - personalSpace/2;
        limSpeed = new PVector(speed.x*-1,speed.y);
      }else if(pos.x -personalSpace/2 < 0){
        pos.x = personalSpace/2;
        limSpeed = new PVector(speed.x*-1,speed.y);
      }
   
      if(pos.y +personalSpace/2 > height){
        pos.y = height - personalSpace/2;
        limSpeed = new PVector(speed.x,speed.y * -1);
      }else if(pos.y -personalSpace/2 < 0){
        pos.y = personalSpace/2;
        limSpeed = new PVector(speed.x,speed.y * -1);
      }
      
      if(abs(speed.x - limSpeed.x) < 0.1 || abs(speed.y - limSpeed.y) < 0.1){
        speed = PVector.lerp(speed,limSpeed,rotateSpeed);
      }
      if(id == 0){
        //println("Pos: "+ pos + ", Speed: " + speed + ", LimSpeed: " + limSpeed + ", Distanz: " + (abs(speed.x - limSpeed.x) < 0.1|| abs(speed.y - limSpeed.y) < 0.1));
      }*/
     }
     
     void changeSpeedTo(PVector newSpeed){
       newSpeed.normalize().mult(magnitudeLimit);
       limSpeed = newSpeed.copy();
     }
     
     void draw(){
       ellipse(pos.x,pos.y,personalSpace,personalSpace);
       PVector copySpeed = speed.copy();
       PVector gazePoint = pos.add(copySpeed.normalize().mult(personalSpace/2f));
       ellipse(gazePoint.x,gazePoint.y,1,1);
     }
}
