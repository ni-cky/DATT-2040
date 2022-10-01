int stepSize = 100;


int scwidth = 700;

int colums = scwidth/stepSize;
int rows = scwidth/stepSize;

boolean flipped = false;

void setup(){
 size(700,700);
 println("Colums: ",colums);
 noFill();
}

void draw(){
  //noLoop();
  background(255);
  for(int counter = 0; counter < 2; counter++){
    pushMatrix();
    translate(width/2,height/2);
    if(counter == 1)
      flipped = true;
    else
      flipped = false;
    drawGrid();
    popMatrix();
  }
  println(frameRate);
  
}

void drawGrid(){
 for(int i = 0;i < rows;i++){
    for(int j = 0;j < colums;j++){
      float x = (j-colums/2.) * stepSize;
      float y = (i-rows/2.) * stepSize;
      if(flipped)
      {
        x = (width/2) + width/2 - (j+colums/2.) * stepSize - stepSize;
        //y += stepSize;
      }
      
      if(!flipped){
      if(getA(i-(int)colums/2,j-(int)colums/2) != 0)
      {
         rect(x,y,stepSize,stepSize);
      
      beginShape();
      for(int si = (int) x; si < x+stepSize; si++){
    
        int i2 = i -(int)colums/2;
        int j2 = j-(int)colums/2;
        float sx = si;
        float a = getA(i2,j2);
        float b = getA(j2,i2);
        float c = frameCount*0.01;
        float d = y+stepSize/2;
        float sy = a * sin(b*(sx + c)) + d;
        //float sy = y+stepSize/2 + sin(frameCount*0.1+si*(i2*j2))*10;
        if(a != 0)
          vertex(sx,sy);
      }
      endShape();
      }
    }
      else{
      if(getA(i+(int)colums/2,j+(int)colums/2) != 0)
      {
         rect(x,y,stepSize,stepSize);
         ellipse(x,y,10,10);
      
      beginShape();
      for(int si = (int) x+stepSize; si > x; si--){
    
        int i2 = i -(int)colums/2;
        int j2 = j-(int)colums/2;
        
        float sx = si;
        float a = getA(j2,i2);
        float b = getA(i2,j2);
        float c = frameCount*0.01;
        float d = y+stepSize/2;
        float sy = a * sin(b*(sx + c)) + d;
        //float sy = y+stepSize/2 + sin(frameCount*0.1+si*(i2*j2))*10;
        if(a != 0)
          vertex(sx,sy);
      }
      endShape();
      }
      //println(i + " " + j);
    }  
    }
  } 
}

float getA(int i, int j){
  if(i== 0 && j == 0)
    return 1;
  if((i > j && i > 0 && j > 0) || (i < j && i < 0 && j < 0))
    return i*10;
  if((j > i && i > 0 && j > 0) || (j < i && i < 0 && j < 0))
    return j*10;
  if(i == j)
    return i;
  return 0;
    //return i == 0 ? j == 0 ? 1 : j*10 : i*10;
}
