float scalar =1.0; //Float for form scalling.
float breatheSpeed = -0.002; //Speed of breating motion.
ArrayList<Form> breathingShape; //Add array dynamically.
int index =0;
final int MAX = 800; // Maximum of form.
Table dataTable; //Data Table.
MonthEntry [] monthData; // Array of entries for each month.
long timeInterval=10000; // Time to switch from one motion to other.
long startTime;
long timePassed;
int currentMonthIndex = 0;// Index to know which month we are using for the data

float birthAverage; // Average of birth.
float deathAverage; // Average of death.

float monthScalarSpeed; // Scalling speed of month.

void setup() {
  size(displayWidth, displayHeight, P3D); //Size of screen
  background(0); // background color

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
    birthAverage +=birth;
    deathAverage +=death;
    monthData[tableCounter] = new MonthEntry(month, birth, death);
    tableCounter++;
  }
  birthAverage/=12.0; // Calculate the average of birth divided by 12 months.
  deathAverage/=12.0; // Calculate the average of death divided by 12 months.

  for (int i =0; i< monthData.length; i++)
  {
    monthData[i].birthDifference = (monthData[i].birth - birthAverage); // To calculate a difference between average and each month for birth.
    monthData[i].deathDifference = ( monthData[i].death - deathAverage); // To calculate a difference between average and each month for death.
    float temp = monthData[i].birthDifference/1000; // 
    monthData[i].monthScalar = 1-(1+temp);
  }
  println(birthAverage);
  println(deathAverage);
}


void draw()
{
  background(0);

  // Build shape
  if (index<MAX)
  {
    Form prev = breathingShape.get(index-1);
    breathingShape.add(new Form(prev));
    index++;

    // Set the timer first time.
    if (index ==MAX)
    {
      startTime =millis();
      monthData[currentMonthIndex].printData();
    }

    for (int i=0; i< breathingShape.size(); i++)
    {
      breathingShape.get(i).displayForm();
    }
  } 

  // Change shape
  else {

    timePassed = millis()- startTime;

    if (timePassed>timeInterval)
    {
      if (currentMonthIndex<11)
      {
        // Go to next month
        startTime =millis();
        timePassed =0;
        currentMonthIndex++;
        //monthData[currentMonthIndex].printData();
      }
    }

    //Data that we are using.
    //scaleMonth();

    breathing();
    for (int i=0; i< breathingShape.size(); i++)
    {
      breathingShape.get(i).displayBreathing();
    }
  } //else later Data Month
}

void scaleMonth()
{
  float m = monthData[currentMonthIndex].monthScalar;
  if (m<1) {
    monthScalarSpeed = -0.01; //If monthScalar is less than one, go down.
    println("mScalar"+ monthData[currentMonthIndex].monthScalar);
    if (scalar > monthData[currentMonthIndex].monthScalar )
    {
      scalar +=monthScalarSpeed;
      println(scalar);
    }
  } else
  {
    monthScalarSpeed = 0.01; //If monthScalar is less than one, go up.
  }
}

void breathing() {
  stroke(169, 204, 233, 100);  
  if (scalar < 0.6 || scalar >1.0) //Decreasing the size.
  {
    breatheSpeed*=-1;
  }
  scalar+=breatheSpeed;
  // println(scalar);
}

/* References :
 Learning Processing ( second edition) by Daniel Shiffman
 Nature of Code by Daniel Shiffman
 */