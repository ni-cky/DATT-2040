class Snek{
  
    //Static fields
    float distanceSkalarToOtherAgents = 500f;
    float accSkalar = 0.4;
    float amplitudeSkalar = 2;
    float periodSkalar = 10;
  
    //Agent specific fields
    int id;
    PVector pos;
    PVector speed;
    PVector acc;
    PVector sColor;
    boolean inactive = true;
    
    Snek[] sneks;
    
    float magnitudeLimit = 5;
    
    float personalSpace = 50;
    
    boolean vertical = false;
    
    Snek(int pId, Snek[] pSneks, PVector pPos, PVector pSpeed, float pSpace){
      id = pId;
      pos = pPos;
      speed = pSpeed;
      speed.limit(magnitudeLimit);
      acc = pSpeed;
      acc.limit(magnitudeLimit);
      personalSpace = pSpace;
      sneks = pSneks;
      sColor = new PVector(255,255,255);
    }
    
    Snek(int pId, Snek[] pSneks, PVector pPos, PVector pSpeed, float pSpace, boolean vertical){
      this(pId,pSneks,pPos,pSpeed,pSpace);
      this.vertical = vertical;
    }
    
    void move(){
      if(inactive){
        PVector mouse = new PVector(mouseX, mouseY);
        if(PVector.dist(mouse,pos) < 50){
          inactive = false;
        }
      }else{
        //Acc1: Stay away from oter agents
        PVector acc1 = new PVector(0,0,0);
        for(Snek s : sneks){
          if(id != s.id){
            if(PVector.dist(pos, s.pos) < personalSpace){
              acc1.add(PVector.sub(pos,s.pos).mult(distanceSkalarToOtherAgents));
            }
          }
        }
        
        acc1.limit(personalSpace);
        //Automatical Behaviour through same acc
        //PVector acc2 = new PVector(0,0,0);
        
        PVector mouse = new PVector(mouseX, mouseY);
        PVector acc3 = PVector.sub(mouse, pos);
        
        acc = PVector.add(acc1,acc3);
        
        // Set magnitude of acceleration
        //acc.setMag(0.02);
  
        acc.normalize();
        acc.mult(accSkalar);
  
        // Velocity changes according to acceleration
        speed.add(acc);
        // Limit the velocity by limit
        speed.limit(magnitudeLimit);
        // Location changes by velocity
        pos.add(speed);
  
        if ( (pos.x > width) || (pos.x < 0)) {
          speed.x = speed.x * -1;
        }
  
        //check to see if pos.y is contained within the screen width
        if ( (pos.y > width) || (pos.y < 0)) {
  
          speed.y = speed.y * -1;
        }
      }
      
      
     }
     
     void draw(){
       stroke(sColor.x,sColor.y,sColor.z);
       pushMatrix();
       translate(pos.x,pos.y);
       float rotation = PVector.angleBetween(speed,new PVector(-1,0,0));
       rotation = speed.x > 0 ? (speed.y > 0 ? -rotation : rotation) : speed.y > 0 ? -rotation : rotation;
       rotate(rotation);
       if(vertical && inactive){
         rotate(HALF_PI);
       }
       //beginShape();
      for(float si = -personalSpace; si < 0; si+=2f){
        
        float sx = si;
        float a = inactive ? 0 : speed.mag()/amplitudeSkalar;
        float b = inactive ? 0 : speed.mag()/periodSkalar;
        float c = frameCount*speed.mag()/5.;
        float d = 0;
        float sy = a * sin(b*(sx + c)) + d;
        ellipse(sx,sy,2,2);
      }
      //endShape();
      popMatrix();
      //ellipse(pos.x+speed.x,pos.y+speed.y,10,10);
      if(id==0)
      println(PVector.angleBetween(new PVector(0,-1,0),new PVector(-1,0,0)));
     }
}
