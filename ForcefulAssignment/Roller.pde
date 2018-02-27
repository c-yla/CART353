class Roller {
  //mass
  float mass;
  //location
  PVector location;
  //mesh of roller
  float r = 0;
  //gravity
  float G;

//Setting the new location of the roller
Roller (){
  location = new PVector (width/2,height/2);
  mass = 20;
  G = 0.4;
}

//Roller will be able to catch the food if the distance between the vectors are 6.
void catchFood(Food f){
  PVector two_dLoc = new PVector(location.x,location.y,0);
  PVector force = PVector.sub (two_dLoc,f.position);
  float distance = force.mag();
  if(distance< 6.0)
  {
    f.isCaught =true;
  }
}


//The food items are repelled from the roller. It forces them to go the opposite direction from the roller.
PVector repel (Food f){
  PVector two_dLoc = new PVector(location.x,location.y,0);
  PVector force = PVector.sub (two_dLoc,f.position);
  float distance = force.mag();
 
  distance = constrain (distance,8.0,10.0);
  
  force.normalize();
  float strenght = ( G * mass * f.mass) / (distance * distance);
  //By adding -, this will enable the food to use the opposite strenght.
  force.mult (-strenght);
  return force;
}

/*Display the roller.
At first, I had a fill but my food items would stay behind my roller. I changed it to noFill
for the user to see if they caught any foods yet.
*/
void display (){
   r+=10;
   pushMatrix();
   noFill();
   stroke(255,197,0);
   location = new PVector(mouseX,mouseY);
   translate (mouseX,mouseY,0);
   rotateX(r*0.01);
   rotateY(r*0.01);
   sphere(70);
   popMatrix();
  }
 }