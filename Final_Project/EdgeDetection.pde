import java.util.Arrays;
import java.util.Collections;
import java.util.List;

float[][] kernel =
  {{ -1, 0, 1 },
  { -1, 0, 1 },
  { -1, 0, 1 }};


PImage edgeImg;

color[] detectEdges(PImage unprocessedImage) {
  unprocessedImage.loadPixels();

  // Create an opaque image of the same size as the original
  edgeImg = createImage(unprocessedImage.width, unprocessedImage.height, RGB);

  // Loop through every pixel in the image
  for (int y = 1; y < unprocessedImage.height-1; y++) {   // Skip top and bottom edges
    for (int x = 1; x < unprocessedImage.width-1; x++) {  // Skip left and right edges

      float sumr = 0; // Kernel sum for red pixel
      float sumg = 0; // Kernel sum for green pixel
      float sumb = 0; // Kernel sum for blue pixel

      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {

          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*unprocessedImage.width + (x + kx);

          // calculate r,g,b values
          float valr = red(unprocessedImage.pixels[pos]);
          float valg = green(unprocessedImage.pixels[pos]);
          float valb = blue(unprocessedImage.pixels[pos]);
          // Multiply adjacent pixels based on the kernel values
          sumr += kernel[ky+1][kx+1] * valr;
          sumg += kernel[ky+1][kx+1] * valg;
          sumb += kernel[ky+1][kx+1] * valb;
        }
      }

      // based on the sum from the kernel
      edgeImg.pixels[y*imgs[currImg].width + x] = color(sumr, sumg, sumb);
    }
  }
  // State that there are changes to edgeImg.pixels[]
  edgeImg.updatePixels();
  edgeImg.loadPixels();

  return edgeImg.pixels;
}

float[] getHeightMap(color[] pix, boolean random){
  float[] heightMap = new float[pix.length];
  
  for(int y = 0; y < edgeImg.height;y++){
    ArrayList<Integer> indexes = new ArrayList();
    for(int x = 0; x < edgeImg.width;x++){
      int i = y*edgeImg.width+x;
      if(pix[i] != color(0,0,0)){
        indexes.add(x);
      }
    }
    if(indexes.size() == 0){
      indexes.add(0);
    }
      indexes.add(edgeImg.width-1);
    int lastIndex = 0;
    for(int n = 1; n < indexes.size();n++){
      float b = TWO_PI / ((indexes.get(n)-lastIndex)*2);
      if(random)
        b = random(1) <0.5? b : -b;
      int xl = 0;
      for(int x = lastIndex; x < indexes.get(n); x++){
        heightMap[y*edgeImg.width+x] =  100* sin((b * xl));
        xl++;
      }
      lastIndex = indexes.get(n);
    }
  }
  
  return heightMap;
}

//Source: https://www.digitalocean.com/community/tutorials/shuffle-array-java
ArrayList<Agent> shuffle(ArrayList<Agent> a){
  List<Agent> intList = a;
  Collections.shuffle(intList);
  a = new ArrayList<Agent>(intList);
  return a;
}
