/*
Curvy Art
by Nicky Schubert

Controls:
Mouse: PeasyCam controls
Left/Right Arrow Key: Switch to next picture
Any other key: Realign current image plane with the camera

Process:
Each pixel of the image is an agent that gets assigned a new random pixel each time the camera is realigned or the pixture is changed.
Each picture has first an edge detection kernel running over it and then displaces the pixels between two edges along a sine wave that has a period double the distance between the edges.
That results in all edges being connected by arches.
Those arches have a random chance of going towards the camera and away.
*/
import peasy.*;
PeasyCam cam;

// Object to keep track of matrix transforms
MatrixTracker2D matrix = new MatrixTracker2D();

PImage[] imgs;
int currImg = 0;
color[] c;

float[] startPosCam;

ArrayList<Agent> agents;

void setup() {
  cam = new PeasyCam(this, 500);
  
  startPosCam = cam.getPosition();
  
  agents = new ArrayList<Agent>();//imgs[0].pixels.length);

  imgs[0].loadPixels();
  for(int p = 0; p < imgs[0].pixels.length;p++){
    int x = p % imgs[0].width ;
    int y = p / imgs[0].width ;
    float[] rot = {0f,0f,0f};
    float[] trans = {0f,0f,0f};
    agents.add(new Agent(rot,trans,new PVector(x-imgs[0].width/2,y-imgs[0].height/2,0),imgs[0].pixels[p]));
    agents.get(p).display();
  }
  color[] processedImg = detectEdges(imgs[0]);
}

void settings() {
  imgs = new PImage[3];
  imgs[0] = loadImage("dancer.png");
  imgs[1] = loadImage("Test.png");  
  imgs[2] = loadImage("DALLE_OUT.jpg");
  int sizeX = 10;
  int sizeY = 10;
  for(PImage i : imgs){
    if(i.width > sizeX)
      sizeX = i.width;
    if(i.height > sizeY)
      sizeY = i.height;
  }
  size(sizeX, sizeY,P3D);
  println(imgs[0].height);
  c = new color[imgs[0].width];
}

void draw() {
  background(255);
  for(int p = 0; p < imgs[currImg].pixels.length;p++){
    Agent curr = agents.get(p);
    if(!((abs(curr.pos.x-curr.goal.x) < 0.01) && (abs(curr.pos.y-curr.goal.y) < 0.01) && (abs(curr.pos.z-curr.goal.z) < 0.01)))
      curr.move();
    curr.display();
  }
}

public void keyPressed(){
  if (key == CODED) {
    if (keyCode == RIGHT || keyCode == LEFT) {
      currImg = (currImg +1)%imgs.length;
      println(currImg);
    }
  }
  loadPixels();
  imgs[currImg].loadPixels();
  
  float[] camRot = cam.getRotations();
  float[] camTrans = cam.getLookAt();
  
  if(imgs[currImg].pixels.length > agents.size()){
      for(int pixelIndex = agents.size();pixelIndex < imgs[currImg].pixels.length;pixelIndex++){
        agents.add(new Agent(camRot,camTrans,new PVector(0,0,0),0));
      }
   }
  
  color[] processedImg = detectEdges(imgs[currImg]);
  float[] heights = getHeightMap(processedImg,true);
  agents = shuffle(agents);
  
  for (int i = 0; i < imgs[currImg].pixels.length; i++) {      
    int x = i % imgs[currImg].width; 
    int y = i / imgs[currImg].width;
    float xPos = x-imgs[currImg].width/2;
    float yPos = y-imgs[currImg].height/2;
    agents.get(i).updateGoal(camRot,camTrans,new PVector(xPos,yPos,heights[i]),imgs[currImg].pixels[i]);
  }
  
  if(imgs[currImg].pixels.length < agents.size()){
    for(int index = imgs[currImg].pixels.length; index < agents.size(); index++)
    agents.remove(imgs[currImg].pixels.length);
  }
 
}
