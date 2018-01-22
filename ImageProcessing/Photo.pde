class Photo1 {
  PImage img;
  int circleeffect = 300;
  
  void display(){
    // Load the image at the position 0,0.
    img = loadImage("picture2.jpg");
    tint (255,200);
    image(img, 0, 0);
    /* Loads pixels of the image. Pixels must be loaded in order for the system to pull
       out the color components of each pixel.
    */
    loadPixels();
    img.loadPixels();
  }
 
 void drawPoint(){
   // This will loop through every column ( x = horizontal).
   int x = int (random ( img.width));
   // This will loop through every row ( y = vertical ).
   int y = int (random ( img.height));
   // This will allow the location of the pixels to be calculated.
   int loc = x + y * img.width;

   /* 
   These functions float r, g, b will pull the color components from each pixel 
   of the image. 
   */
   float r = red ( img.pixels [loc]);
   float g = green ( img.pixels [loc]);
   float b = blue ( img.pixels [loc]);
   noStroke();
   // 100 = transparency.
   fill(r,g,b,100);
   // Using ellipse to color the pixels of the photo.
   ellipse( x,y,circleeffect, circleeffect);
 }
 
 void drawBrightness(){
   /*
   These functions below will do the following:
   It will loop through every column ( x = horizontal).
   It will loop through every row ( y = vertical ).
   It will allow the location of the pixels to be calculated.
   */
    for (int x =0; x<img.width;x++){
      for (int y=0; y < img.height;y++){
        int loc= x+y* img.width;
        float r = red (img.pixels [loc]);
        float g = green (img.pixels [loc]);
        float b= blue (img.pixels [loc]);
        
        // User will be able to adjust the brightness with mouse X.
        float adjustBright = map (mouseX,0,width,0,8);
        r *=adjustBright;
        g *=adjustBright;
        b *=adjustBright;
        
        //The change of color are constrained with the last value (100,120,100).
        r=constrain (r,0,255);
        g=constrain (g,0,255);
        b=constrain (b,0,255);
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