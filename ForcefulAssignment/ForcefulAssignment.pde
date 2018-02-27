/*
Cayla Leung

The user must use the mouse to navigate the ball to catch the food items.
The food items are repelling from the roller but once the user tries to catch the food items,
the food will be attracted to the roller.

*/

//Food array
Food [] foods = new Food [48];
//Find these pngs inside the data folder
String []iconNames  = {"chickenwing.png", "cream.png", "apple.png","croissant.png","donut.png","egg.png","pineapple.png","pizza.png"};
Roller r;



void setup() {
  //No Stroke for the roller
  noStroke();
  //Display size with Z-dimensions.
  size(700, 500, P3D); 

  //Display new food between the sizes of 30 & 50, random position, food images.
  for (int i = 0; i < foods.length; i++) {
    foods [i]= new Food (random(30, 50), random(width), random (height), iconNames[i%7]);
  }
  //Initialize our new roller
  r = new Roller ();
 
}




void draw() {
  //Must display a new background 
  background(203,229,241);
  textSize(20);
  fill(68, 138, 198);
  text("Feed Toppo by capturing all the food with the mouse!", 200/2, 500/2,0);
  
  //Display roller
  r.display();

 
 //If food isn't caught , apply force. If the food is caught, the food will be stuck in the roller.
  for (int i = 0; i < foods.length; i++) {
    r.catchFood(foods[i]);
    if (foods[i].isCaught ==false)
    {
      PVector force = r.repel(foods[i]);
      foods[i].applyForce(force);

      foods[i].update();
      foods[i].checkEdges();
    } 
    else
    {
      //When the food is attracted, take the roller's X location.
      foods[i].position = r.location.copy();
    }

    foods[i].drawFood();
    
  }
  
 
}

/* References :
 Learning Processing ( second edition) by Daniel Shiffman
 Nature of Code by Daniel Shiffman
 */