class Image1 {
  PImage img;
  //To do the drawMono: it is a must to have two images. One original and one to be displayed.
  PImage destination;

  void display(){
    //Load the image at position 0,0.
    img = loadImage("picture1.jpg");
    image(img, 0, 0);
    // The destination function will create a blank image which is the same as img.
    destination = createImage (img.width,img.height,RGB);
  }
  
  
  void drawMono(){
    //I choose 50 as my threshold because I wanted the image to be less harsh.
    float threshold = 50;
    // The system will go through and check both image pixels.
    img.loadPixels();
    //destination meaning it will load the image that is " to be displayed".
    destination.loadPixels();
    
    // This will loop through every column ( x = horizontal).
    for (int x=0; x< img.width; x++){
      // This will loop through every row ( y = vertical ).
      for (int y=0; y < img.height; y++){
        // This will allow the location of the pixels to be calculated.
        int loc = x+y*img.width;
        /*This indicates that if the value of the brightness of the pixel is between 0 & 255,
          make it white if it is >100, make it black if < 100.
          It locates the value of the original pixel color of the image.
        */
        if (brightness(img.pixels[loc])> threshold){
          //if value of brightness of pixel more than 100 -> make it 255 (white).
          destination.pixels[loc] = color (255);
        }else{
          //else the value of brightness of pixel less than 100 -> make it 0(black).
          destination.pixels[loc]=color (0);
          
        }
      }
    }
     destination.updatePixels();
     image(destination,0,0);
  }
  
  void drawBrightnessColor(){
    /* Loads pixels of the image. Pixels must be loaded in order for the system to pull
       out the color components of each pixel.
    */
    loadPixels();
    img.loadPixels();
    // This will loop through every column ( x = horizontal).
    for (int x =0; x<img.width;x++){
      // This will loop through every row ( y = vertical ).
      for (int y=0; y < img.height;y++){
        // This will allow the location of the pixels to be calculated.
        int loc= x+y* img.width;
       
        /* These functions float r, g, b will pull the color components from each pixel 
        of the image. 
        */
        float r = red (img.pixels [loc]);
        float g = green (img.pixels [loc]);
        float b= blue (img.pixels [loc]);
        
        // User will be able to adjust the brightness with mouse X.
        float adjustBright = map (mouseX,0,width,0,8);
        r *=adjustBright;
        g *=adjustBright;
        b *=adjustBright;
        
        //The change of color are constrained with the last value (100,120,100).
        r=constrain (r,0,100);
        g=constrain (g,0,120);
        b=constrain (b,0,100);
        color c = color (r,g,b);
        pixels [loc]=c;
      }
    }
    // This function is called after the loadpixels.
    updatePixels();
    
  }
 
}

/* References :
   Learning Processing ( second edition) by Daniel Shiffman
*/