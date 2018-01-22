Image1 image1;
Photo1 photo1;
int number = 0;

void setup() {
  // Size of canvas
  size(300,300);
  image1 = new Image1();
  photo1= new Photo1();
  
}

void draw() {
  image1.display();
  image1.drawBrightnessColor();
  // Must write if keyPressed because it is in void draw.
   if (keyPressed){
    /*if the key 32 " SPACEBAR" is pressed, it will display photo1.
     User will be able to adjust the brightness with the mouse while 
    having some circle effects.
    */
    if (key ==32){
       photo1.display();
       photo1.drawBrightness();
       photo1.drawPoint();
    }

  }
     if (keyPressed){
    //if the key b or B is pressed, it will display image1.
    if (key =='b' || key == 'B'){
       image1.display();
       image1.drawMono();
    }

  }
  }
  
 void keyPressed(){
   // if the key "s" or capital 'S' is pressed, it will save the image to the folder.
  if(key == 's' || key == 'S'){
    // The string allows the user to save their images in order
    // ex : canvas00.jpg ... canvas1.jpg
    String s = "canvas" + number +".jpg";
    save(s);
    // Number ++ means that the number will increment.
    number++;
  }
 
}
/* References :
   Learning Processing ( second edition) by Daniel Shiffman
*/