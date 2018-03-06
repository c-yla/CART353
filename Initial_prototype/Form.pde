class Form {
  int sides = 8; //  oat[] x = new  oat[sides];
  float [] x1 = new float[sides];
  float [] y1 = new  float[sides];
  float [] z1 = new float[sides];
  float variance = 8;  
  int radius = 200; // Radius of form
  PVector centerPoint; // Find center point
  float gradientIndex=0;

  Form(int index)
  {
    centerPoint = new PVector(width/2, height/2);
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
      x1[i] = cos(angle*i) * radius;
      y1[i] = sin(angle*i) * radius;
      z1[i] = tan(angle*i) * radius;
    }
  }

  void evolve(Form prev) {
    for (int i=0; i < sides; i++) {
      x1[i] = prev.x1[i]+random (-variance/2, variance/2);
      y1[i] = prev.y1[i]+random (-variance/2, variance/2);
      z1[i] = prev.z1[i]+random (-variance/2, variance/2);
    }
  }

 void displayForm()
  {
    noFill();
    strokeWeight(0.5);
    stroke(255, 100);
    pushMatrix();
    translate(centerPoint.x, centerPoint.y);
    scale(1, 1, 1);
    beginShape();
    curveVertex(x1[sides-2], y1[sides-2], 0);
    for (int i=0; i < sides; i++) {
      curveVertex(x1[i], y1[i], 0);
    }
    curveVertex(x1[0], y1[0], 0);
    curveVertex(x1[1], y1[1], 0);
    endShape();
    popMatrix();
  }

// State of the pulsing movement.
  void displayBreathing()
  {
    noFill();
    strokeWeight(0.5);
    
    color from = color(255,100); // Go from white color
    color to = color(40, 94, 140,50); // To blue color
    color gradientColor = lerpColor(from, to, gradientIndex);
    stroke(gradientColor);
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
    
    if(gradientIndex<1)
    { 
      
      gradientIndex+=.0008; //how fast color gradient should change.
    }
  }


// State of the month.
  void displayMonth()
  {
    noFill();
    strokeWeight(0.5);
    stroke(255, 100);
    pushMatrix();
    translate(centerPoint.x, centerPoint.y);
    scale(1, scalar, 1);
    beginShape();
    curveVertex(x1[sides-2], y1[sides-2], 0);
    for (int i=0; i < sides; i++) {
      curveVertex(x1[i], y1[i], 0);
    }
    curveVertex(x1[0], y1[0], 0);
    curveVertex(x1[1], y1[1], 0);
    endShape();
    popMatrix();
  }
}