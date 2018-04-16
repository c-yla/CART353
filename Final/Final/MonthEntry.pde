class MonthEntry //Class that reads the data of month, birth and death.
{
  String month;
  int birth;
  int death;
  float birthDifference;
  float deathDifference;
  float monthScalar;
  float monthDeathScalar;

  MonthEntry(String m, int b, int d ) // MonthEntry to read the following.
  {
    month =m;
    birth =b;
    death = d;
  }

  //Print data at the bottom. 
  void printData() 
  {
    println(month  + " birth:: " +birthDifference + "death :: "+deathDifference);
  }
}