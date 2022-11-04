PImage img;
color[] c;

void setup() {

}

void settings() {

  img = loadImage("Test.png");
  size(img.width, img.height);
  println(img.height);
  c = new color[img.width];
}

void draw() {

  img.loadPixels();
  for(int i = 0; i < img.height;i++){
    color brightestPixel = color(0);
    int indexB = 0;
    color darkestPixel = color(255);
    int indexD = 0;
    for(int j = 0; j < img.width;j++){
      color cur = img.pixels[i*img.width+j];
      if(brightness(cur) >= brightness(brightestPixel)){
        indexB = j;
        brightestPixel = cur;
      }
      if(brightness(cur) <= brightness(darkestPixel)){
        indexD = j;
        darkestPixel = cur;
      }
    }
    if(abs(indexB-indexD) != 0){
      color[] colorLine = new color[abs(indexB-indexD)];
      colorLine = subset(img.pixels,indexB < indexD ? indexB : indexD, abs(indexB-indexD));
      
      colorLine = sortColors(colorLine);
      
      if(indexB < indexD)
        colorLine = reverse(colorLine);
      
      img.pixels = splice(img.pixels, colorLine, i*width+abs(indexB-indexD));
    }
    println(i + "," + indexB+ "," + indexD);
  }

  img.updatePixels();

  image(img, 0, 0);

  //try removing noLoop(), see what happens
  noLoop();
}

color[] sortColors(color[] a){
  for (int passnum = a.length-1;passnum > 0; passnum--){
    for(int i = 0; i < passnum; i++){
      if (brightness(a[i])>brightness(a[i+1])){
          color temp = a[i];
          a[i] = a[i+1];
          a[i+1] = temp;
      }                
    }       
  }       
  return a;
}
