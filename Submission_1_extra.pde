//how many rows and columns in our grid
int col = 2;
int row = 2;

//to hold the stepsize
int stepx, stepy;

int randomScale = 10;
int recursionDepth = 3;

void setup() {
  size(500, 500);

  stepx = width/col;
  stepy = height/row;

  frameRate(1);

  //noLoop();
}

void draw() {
  for (int i = 0; i < col; i++) {
    for (int j = 0; j < row; j++){    
      //rect(i*stepx,j*stepy,stepx,stepy);
      int x = i * stepx;
      int y = j * stepy;
      
      
      
      drawGrid(x,y,stepx,stepy, 1);
    }
  }
}

void drawGrid(int startx,int starty,int lengthx,int lengthy, int levelOfRecursion){
  pushMatrix();
  translate(startx,starty);
  int colR = randomly(col*randomScale);
  int rowR = randomly(row*randomScale);
  int stepxR = randomly(stepx);
  int stepyR = randomly(stepy);
  for (int i = 0; i < colR; i++) {
    for (int j = 0; j < rowR; j++){    
      //rect(i*stepx,j*stepy,stepx,stepy);
      int x = i * stepxR;
      int y = j * stepyR;
      
      if(levelOfRecursion >= recursionDepth){
        fill(randomly(255),x*200,y*200);
        rect(x,y,stepx,stepy);
      }else{
        drawGrid(x,y,stepxR,stepyR, levelOfRecursion+1);
      }
    }
  }
  popMatrix();
}

int randomly(int r){
  return (int)random(r);
}
