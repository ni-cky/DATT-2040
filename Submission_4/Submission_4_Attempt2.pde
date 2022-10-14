Snek[] sneks;
int amount = -1;

int grid = 9;

int stepSize = 50;

void setup() {
  size(450,450);
  background(0);
  stroke(255);
  
  
  if(amount > 0){
    
    sneks = new Snek[amount];
    for(int i = 0; i < amount; i++){
      sneks[i] = new Snek(i, sneks, new PVector(random(width), random(height)), new PVector(0, 0), 50);
    }  
  }else{
    grid++;
    boolean colSwitch = random(1) < 0.5;
    sneks = new Snek[grid*grid*2];
    for(int i = 0; i < grid; i++){
      for(int j = 0; j < grid; j++){
        println(i*grid+j);
        sneks[i*grid+j] = new Snek(i*grid+j, sneks, new PVector((i)*stepSize, (j)*stepSize), new PVector(0, 0), 50);
        sneks[i*grid+j].sColor = colSwitch ? new PVector(255./grid*i,255./grid*j,255) : new PVector(255./grid*i,255,255./grid*j);
      }
    }
    for(int i = 0; i < grid; i++){
      for(int j = 0; j < grid; j++){
        println(i*grid+j);
        sneks[grid*grid+i*grid+j] = new Snek(grid*grid+i*grid+j, sneks, new PVector((i)*stepSize, (j)*stepSize), new PVector(0, 0), 50,true);
        sneks[grid*grid+i*grid+j].sColor = colSwitch ? new PVector(255./grid*i,255./grid*j,255) :  new PVector(255./grid*i,255,255./grid*j);
      }
    }
  }
}

void draw() {
  background(0);

  for(Snek s : sneks){
    s.move();
    s.draw();
  }  
}
void mousePressed() {

  if(amount > 0){
    
    sneks = new Snek[amount];
    for(int i = 0; i < amount; i++){
      sneks[i] = new Snek(i, sneks, new PVector(random(width), random(height)), new PVector(0, 0), 50);
    }  
  }else{
    grid++;
    boolean colSwitch = random(1) < 0.5;
    sneks = new Snek[grid*grid*2];
    for(int i = 0; i < grid; i++){
      for(int j = 0; j < grid; j++){
        println(i*grid+j);
        sneks[i*grid+j] = new Snek(i*grid+j, sneks, new PVector((i)*stepSize, (j)*stepSize), new PVector(0, 0), 50);
        sneks[i*grid+j].sColor = colSwitch ? new PVector(255./grid*i,255./grid*j,255) : new PVector(255./grid*i,255,255./grid*j);
      }
    }
    for(int i = 0; i < grid; i++){
      for(int j = 0; j < grid; j++){
        println(i*grid+j);
        sneks[grid*grid+i*grid+j] = new Snek(grid*grid+i*grid+j, sneks, new PVector((i)*stepSize, (j)*stepSize), new PVector(0, 0), 50,true);
        sneks[grid*grid+i*grid+j].sColor = colSwitch ? new PVector(255./grid*i,255./grid*j,255) :  new PVector(255./grid*i,255,255./grid*j);
      }
    }
  }
}
