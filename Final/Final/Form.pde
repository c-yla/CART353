class Form {
  
  int sides = 8; //  Amount of sides.
  float [] x1 = new float[sides]; // New X sides.
  float [] y1 = new  float[sides]; // New Y sides.
  float variance = 8; // How the shape is varied. 
  int radius = 180; // Radius of form.
  PVector centerPoint; // Find center point.
  float gradientIndex=0; // Gradient for death.
  float gradientIndex1 = 0.3; // Gradient for breathing.
  color gradientColor; // Gradient for death.
  color gradientColorTwo; // Gradient for breathing.

  Form(int index)
  {
    centerPoint = new PVector(width/2, height/2); // Display the form in the center point.
    if (index ==0)
    {
      evolveInitial(); // Start the initial evolving of shape.
    }
  }

  Form(Form prev) // Take the previous shape and evolve with the previous shape.
  {
    centerPoint = new PVector(width/2, height/2);
    evolve(prev);
  }

  // First State ( representing every day routine)
  void evolveInitial() 
  {
    float angle = radians(360/ float(sides));
    for (int i=0; i < sides; i++) {
      x1[i] = cos(angle*i) * radius; // Calculating the position of each one of the lines with x.
      y1[i] = sin(angle*i) * radius; // Calculating the position of each one of the lines with y.
    }
  }

  void evolve(Form prev) {
    for (int i=0; i < sides; i++) {
      x1[i] = prev.x1[i]+random (-variance/2, variance/2); // Using the previous x while randomizing it to get the next one.
      y1[i] = prev.y1[i]+random (-variance/2, variance/2); // Using the previous y while randomizing it to get the next one.
    }
  }
  void displayForm() // Display Form
  {
    noFill();
    strokeWeight(0.5);
    smooth();
    stroke(255, 100);
    pushMatrix();
    translate(centerPoint.x, centerPoint.y);
    scale(1, 1, 1);
   
    beginShape();
    
    // Using the arrays from evolve to display the shape.
    curveVertex(x1[sides-2], y1[sides-2], 0); 
    for (int i=0; i < sides; i++) {
      curveVertex(x1[i], y1[i], 0);
    }
    curveVertex(x1[0], y1[0], 0); 
    curveVertex(x1[1], y1[1], 0);
    
    endShape();
    popMatrix();
  }

  void displayFormGradient() // Gradient for Death
  {
    noFill();
    strokeWeight(0.5);
    smooth();
    stroke(gradientColor); 
    pushMatrix();
    translate(centerPoint.x, centerPoint.y);
    scale(1, 1, 1);
    beginShape();
    
     // Using the arrays from evolve to display the shape.
    curveVertex(x1[sides-1]/3, y1[sides-1]/3);
    for (int i=0; i < sides; i++) {
      curveVertex(x1[i], y1[i], 0);
    }
    curveVertex(x1[0], y1[0], 0);
    curveVertex(x1[1], y1[1], 0);
    endShape();
    popMatrix();
  }

  void manipulateForm(float deathScalar) // Manipulation of Death form.
  {

    for (int i=0; i < sides; i++) {
      if(deathScalar<0) //if month death rate is negative, it moves on x, if positive move on y.
      {
      
      x1[i] +=random(deathScalar, -deathScalar);
      }
      
     else
      {
      y1[i] +=random(-deathScalar, deathScalar);
      }
  
      smooth();
      stroke(gradientColor); 
      strokeWeight(0.5);  
      color from = color(205); // Go from white color
      color to = color(0); // To black
      gradientColor = lerpColor(from, to, gradientIndex);
      if (gradientIndex<1)
      { 

        gradientIndex+=.0005; //how fast color gradient should change.
      }
    }
  }


  // State of the pulsing movement.
  void displayBreathing()
  {
    pushMatrix();
    translate(centerPoint.x, centerPoint.y);
    scale(scalar, scalar, 1);
    beginShape();
    curveVertex(x1[sides-2], y1[sides-2], 0);
    for (int i=0; i < sides; i++) {
      curveVertex(x1[i], y1[i], 0);
    }
    curveVertex(x1[0], y1[0], 0);
    curveVertex(x1[1], y1[1], 0);
    endShape();
    popMatrix();

    color from = color(211, 100); // Go from white color
    color to = color(21, 60, 128, 50); // To blue color
  
    gradientColorTwo = lerpColor(from, to, breathingGradient); // Go from one color to another.

    noFill();
    smooth();
    stroke(gradientColorTwo);
    strokeWeight(0.5);

    if (gradientIndex<1)
    { 

      gradientIndex+=.0003; //how fast color gradient should change.
    }
  }
}