/*
Attribute:
-Reference from Nature of Code by Daniel Shiffman.
-Reference from Processing.org.
-Reference from Minim, http://code.compartmental.net/minim/audioplayer_class_audioplayer.html.
-Reference for colour codes, https://htmlcolorcodes.com .
-Reference from Processing - Generative Design Tutorial by Manuel Kretzer 2016.
-Reference for Births/Death Data from Statistics Canada.
-Sabine assisted me during computation lab hours. 

*/

import ddf.minim.*; // Audio library. I was having problems with the sound library.
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
Minim minim;
AudioPlayer muraMasa;


float scalar =1.0; //Float for form scalling.
float breatheSpeed = -0.005; //Speed of breating motion.
ArrayList<Form> breathingShape; //Add array dynamically.
int index =0; // To keep track of how many shapes there is in the array.
final int MAX = 1000; // Maximum of form.
Table dataTable; //Data Table.
MonthEntry [] monthData; // Array of entries for each month.
long timeInterval=5000; // Time to switch from one motion to other.
long startTime; // Timer for different state of each month and the state within a month.
long timePassed; // Needed for timer.

int counter= 0; //Reset timer
long timeIntervalRemove=10; // Time to remove Lines from birth state.
int currentMonthIndex = 0;// Index to know which month we are using for the data

float birthAverage; // Average of birth.
float deathAverage; // Average of death.

float monthScalarSpeed; // Scalling speed of month.

int state =0; // For each state.
float breathingGradient = 0.3; // Speed for gradient.
boolean once =true; // Needed for the "everyday routine state".

boolean startSketch =true; // Needed for the "everyday routine state".


int maxLines; // Keeps track of how many lines that needs to be removed.
int cIndex =0; // Keeps track of how many lines that make up the form.

void setup() {
  size(displayWidth, displayHeight, P3D); //Size of screen
  background(211); // background color

  minim =new Minim(this);
  muraMasa = minim.loadFile("MuraMasa.mp3");
  muraMasa.loop(); // Loop song.



  monthData = new MonthEntry[12]; // Create the month entries.
  breathingShape = new ArrayList<Form>(); // Create new breathing shape from initial
  breathingShape.add(new Form(index)); // Add new shape 
  index++; // Increment
  dataTable = loadTable("DataCanada.csv", "header"); // Load data table

  int tableCounter =0;
  for (TableRow row : dataTable.rows()) { 
    String month = row.getString("Month"); // Read the month
    int birth = row.getInt("Birth"); // Gather the data of the birth per month
    int death = row.getInt("Death"); // Gather the data of the death per month
    birthAverage +=birth; // Sum of all the births.
    deathAverage +=death; // Sum of all the deaths.
    monthData[tableCounter] = new MonthEntry(month, birth, death); // Passes through month, birth, death.
    tableCounter++; // Adding array of months.
  }
  birthAverage/=12.0; // Calculate the average of birth divided by 12 months.
  deathAverage/=12.0; // Calculate the average of death divided by 12 months.

  for (int i =0; i< monthData.length; i++)
  {
    monthData[i].birthDifference = (monthData[i].birth - birthAverage); // To calculate a difference between average and each month for birth.
    monthData[i].deathDifference = ( monthData[i].death - deathAverage); // To calculate a difference between average and each month for death.
 
    float temp2 = monthData[i].deathDifference/1000;// I divided the numbers by 1000 to get a smaller value.for gradient of death.
    
    monthData[i].monthScalar =  (int)monthData[i].birthDifference/50; // Scalling down the value.
    monthData[i].monthDeathScalar = 1-(1+temp2); // MonthData for death.
  }

}


void draw()
{
  background(211); // Redraw background.

  
  if (startSketch ==true) // Build shape
  {
    if (index<MAX) // If it reaches the max, draw the breathing shape and keep adding from the previous form.
    {
      Form prev = breathingShape.get(index-1);
      breathingShape.add(new Form(prev));
      index++;

      
      if (index ==MAX) // Set the timer first time.
      {
        startTime =millis();
      }

      for (int i=0; i< breathingShape.size(); i++)
      {
        breathingShape.get(i).displayForm(); // Display form.
      }
    } else
    {
      startSketch =false; // Once it's finish it will start running the sketch.
    }
  }

  
  else { // Change shape between states.



    timePassed = millis()- startTime;

    if (timePassed>timeInterval)
    {
      if (currentMonthIndex<11 && state ==3)
      {
        state =0; // Represents everyday routine.
        once=true;

        
        startTime =millis(); // Go to next month
        timePassed =0;
        currentMonthIndex++;
      } else if (state <2)
      {
        startTime =millis();
        timePassed =0;
        state ++;
      } else if (state ==2) {

        breathingShape = new ArrayList<Form>(); // Create new breathing shape from initial.

        breathingShape.add(new Form(0)); // Add new shape for State 3.
        state =3;
        index=1; // Go back to initial "everyday routine state".
        startTime =millis();
        timePassed =0;
      }
    }


     if (state ==0 ) // Birth State.
    {
      //do this only first timer we are in state 0
      if (once ==true)
      {
        breathingGradient =0;
         counter= 0; //reset timer
        if (monthData[currentMonthIndex].monthScalar <0)  // Birth rate for current month - the average calculated over 12 months: use that value ,if it's more than average add lines, if less remove lines.
        {
           
            maxLines = breathingShape.size() - abs((int)monthData[currentMonthIndex].monthScalar); // abs: absolute value, to make value always positive. 
            cIndex = breathingShape.size()-1;
        }
        else
        {
          maxLines = breathingShape.size() + abs((int)monthData[currentMonthIndex].monthScalar);
          cIndex =breathingShape.size();
        }
        once =false;
      }
      
      //timePassedRemove= (millis()/1000- startTimeRemove/1000);
     // println("TIME:: "+timePassedRemove);
    if(counter>timeIntervalRemove)
    {
      println("Manipulaing in state 0");
      if (monthData[currentMonthIndex].monthScalar<0 && cIndex>=maxLines)
      {
        counter= 0; //reset timer
        breathingShape.remove(cIndex);
        cIndex--;

      }

        if (monthData[currentMonthIndex].monthScalar>0 && cIndex<=maxLines)
        {
           counter= 0; //reset timer
            Form prev = breathingShape.get(cIndex-1);
            breathingShape.add(new Form(prev));
            cIndex++;
         }
    }
    // println("counter "+counter);
    counter++;
       
      

      for (int i=0; i< breathingShape.size(); i++)
      {
        breathingShape.get(i).displayForm();
      }
      
      
    } 
 
 
    else if (state ==1) // Death State
    {
      println(monthData[currentMonthIndex].monthDeathScalar);
      for (int i=0; i< breathingShape.size(); i++)
      {
        breathingShape.get(i).manipulateForm(monthData[currentMonthIndex].monthDeathScalar);
      }
      for (int i=0; i< breathingShape.size(); i++)
      {
        breathingShape.get(i).displayFormGradient();
      }
    } 
    
    else if (state ==2) // Breathing State
    {
      breathing();
       for (int i=0; i< breathingShape.size(); i++)
       {
       
         breathingGradient+=.000009; // Speed Gradient of breathing + 0.3 at the top.
         breathingShape.get(i).displayBreathing();
      
       }
       
    } else if (state ==3) { // Build Routine Shape again.

      // Build shape
      if (index<MAX)
      {
        Form prev = breathingShape.get(index-1);
        breathingShape.add(new Form(prev));
        index++;

        for (int i=0; i< breathingShape.size(); i++)
        {
          
          breathingShape.get(i).displayForm();
        }
      }
    }
  }

} 



void breathing() { 
  if (scalar < 0.7 || scalar >1.0) //Decreasing the size.
  {
    breatheSpeed*=-1;
  }
  scalar+=breatheSpeed;

}