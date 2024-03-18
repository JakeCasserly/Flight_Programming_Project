Data flights2k;

void setup()
{
  flights2k = new Data("flights2k.csv");
}


void draw()
{
  int count = 0;
  for(int i=0;i<flights2k.length;i++)
  {
    flights2k.setData(i);
    if(flights2k.cancelled == true) count++;
  }
  println("There are "+count+" cancelled flights");
}
