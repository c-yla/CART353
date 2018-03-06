class MonthEntry
{
  String month;
  int birth;
  int death;
  float birthDifference;
  float deathDifference;
  float monthScalar;

  MonthEntry(String m, int b, int d )
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