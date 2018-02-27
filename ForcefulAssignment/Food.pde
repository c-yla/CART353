class Food {
  //Load Icons
  PImage icon;
  //mass
  float mass;
  //gravity
  float G;
  //position
  PVector position;
  //velocity
  PVector velocity;
  //acceleration
  PVector acceleration;
  //checks if the food is caught 
  boolean isCaught =false;

  // Set the food icons mass,position,velocity,acceleration and the icon's Name.
  Food (float m, float x, float y, String iconName){
    mass =m;
    position = new PVector (x,y);
    velocity= new PVector (0,0);
    acceleration = new PVector (0,0);
    G=1;
    icon = loadImage(iconName);
}

//Draw the foods
void drawFood(){
    pushMatrix();
    translate(position.x,position.y,position.z);
    imageMode(CENTER);
    image(icon,0, 0, mass*2, mass*2);
    popMatrix();
 }

//Apply the force to the PVector, divide it by the mass & + to acceleration.
void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
//Set velocity / speed limit to 5.0.
void update() {
    velocity.limit(5.0);
    velocity.add(acceleration);
    position.add(velocity);

    acceleration.mult(0);
  }
  
  //Nature of Code Chapter 2 
  //This is enables our food objects to bounce back in the canvas once it reaches the edge.
  //This makes sure that it all four corners are affected.
  void checkEdges() {
    if (position.x > width) {
     position.x = width;
      velocity.x *= -1;
      
    } else if (position.x < 0) {
      velocity.x *= -1;
      position.x = 0;
    }
 
    if (position.y > height) {
      velocity.y *= -1;
      position.y = height;
    }
    
 
     if (position.y < 0) {
      velocity.y *= -1;
      position.y = 0;
    }
  }
    
}