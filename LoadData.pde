Data flights2k;
boolean search;

void setup()
{
  flights2k = new Data("flights2k.csv");
  search = true;
}


void draw()
{
  while(search)
  {
    int cancelNum = 0;
    int jfkFlights = 0;
    for(int i=0;i<flights2k.length;i++)
    {
      flights2k.setData(i);
      if(flights2k.cancelled == true) cancelNum++;
      if(flights2k.depData.origin.equals("JFK")) jfkFlights++;
    }
    println("There are "+cancelNum+" cancelled flights");
    println("There are "+jfkFlights+" flights departing from JFK airport");
    search = false;
  }
}