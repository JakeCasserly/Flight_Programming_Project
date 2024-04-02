// cancelled Flights
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
    int jfkArrivals = 0;
    int divertedNum = 0;
    for(int i=0;i<flights2k.length;i++)
    {
      flights2k.setData(i);
      if(flights2k.cancelled == true) cancelNum++;
      if(flights2k.depData.origin.equals("JFK")) jfkFlights++;
      if(flights2k.arrData.dest.equals("JFK")) jfkArrivals++;
      if(flights2k.diverted == true) divertedNum++;
      
    }
    println("There are "+cancelNum+" cancelled flights");
    println("There are "+jfkFlights+" flights departing from JFK airport");
    println("There are "+jfkArrivals+" flights arriving at JFK airport");
    search = false;
  }
}
