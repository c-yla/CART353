//This imports the video library.
import processing.video.*;

//Declaring capture object. Capture the live-video.
Capture video;

float x, y;
float t=50;
int a, b;



void setup() {
  //Declaring the size of the canvas. DisplayWidth & DisplayHeight = full screen.
  size(displayWidth, displayHeight);

  //Initializing the Capture object.
  //this = alert sketch when new video image is captured.
  video = new Capture ( this, displayWidth, displayHeight);

  //This is call the system to start capturing the images.
  video.start();
}

//Capture is it it's own function. Must be written outside from setup & draw.
void captureEvent(Capture video) {
  //This will read from camera when a new image is available.
  video.read();
}


void draw() {
    image(video, 0, 0);
    //Filter of video.
    filter(ERODE);
  
    //If i is less than 100 , i increment..
    for (int i = 0; i < 100; i++) {
    //Get color of screen
    color c= get(a, b);
    //Fill the color in the ellipse.
    fill(c);
    stroke(255);
    strokeWeight(1);
    ellipse (x, y, 15, 15);
  
    stroke(255);
    strokeWeight(1);
    //Run the lines horizontally.
    line (0, y, width, y);

    //Perlin noise
    float n=noise(t);
    y=montecarlo();
    //Map the noise, 0 , 1, 0 and width of canvas.
    x = map(n, 0, 1, 0, width);
    //Map the montecarlo,0,1,0 and height of canvas.
    y = map(y, 0, 1, 0, height);

    t += 0.01;
    //Increase montecarlo
    y++;
  }
}

//Montecarlo function, picking 2 random numbers.
float montecarlo() {
  /* p = probability
   While it's continuously true,
   float r1 is a random value
   check the probability of R1.
   pick another number =r2.
   if r2 is less than P, we find our number r1, if r2 is less than P, go back to step 1 
   and start over.
   */
  while (true) {
    float r1 = random(1);
    float p = r1;
    float r2 = random(1);
    if (r2< p) {
      return r1;
    }
  }
}

//Reference from Processing.org:  https://processing.org/tutorials/video/
//Reference from The Nature of Code by Daniel Shiffman