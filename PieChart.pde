// create PieChart class to show percentage of cancelled/diverted flights

class PieChart
{
  final int HALF_HOUR = 30;
  final int MORNING = 500;
  final int AFTERNOON = 1200;
  final int EVENING = 1700;
  final int NIGHT = 2100;
  
  int x,y,radius,height,width;
  float angle; // angle in radians
  PFont font;
  
  int red,green,blue;
  
  Data data;
  ArrayList<Float> angles;
  ArrayList<String> labels;
  
  String flightCarrier;
  String query;
  readDataTask readPie;
  ExecutorService executorService = Executors.newCachedThreadPool();
  
  PieChart(int x, int y, int radius, Data data, int red, int green, int blue)
  {
    this.x = x;
    this.y = y;
    this.radius = radius;
    height = radius/15;
    width = radius/15;
    this.data = data;
   
    query = "Scheduled";
    
    //colorMode(HSB,360,100,100);
    this.red = red;
    this.green = green;
    this.blue = blue;
    
    angles = new ArrayList<Float>();
    labels = new ArrayList<>();
    angles = percentages();
    
    /*
    * Jake's Code for PieChart class:
    * Implemented a thread to help load in the data
    * such that the pressure is taken off of setup
    */
    readPie = new readDataTask("PieChart");
    executorService.execute(readPie);
  }
  
  ArrayList<Float> percentages()
  {
    ArrayList percentages = new ArrayList<Float>();
    float total = data.length;
    
    switch(query)
    {
      default:
      case "Scheduled":
        float cancelled = 0;
        float diverted = 0;
        float lateArrival = 0;  
        float lateDepart = 0;
        
        for(int i=0;i<data.length;i++)
        {
          if(data.getCancelled(i)) cancelled++;
          if(data.getDiverted(i)) diverted++;
          if(data.getArr(i).getTime() > data.getArr(i).getCRS()+HALF_HOUR) lateArrival++;
          if(data.getDep(i).getTime() > data.getDep(i).getCRS()+HALF_HOUR) lateDepart++;
        }
        cancelled = cancelled*2*PI/total;
        diverted /= total; diverted = diverted*2*PI/total;
        lateArrival = lateArrival*2*PI/total;
        lateDepart = lateDepart*2*PI/total;
        println(cancelled,diverted,lateArrival,lateDepart);
    
        percentages.add(cancelled);
        labels.add("Cancelled");
        percentages.add(diverted);
        labels.add("Diverted");
        percentages.add(lateArrival);
        labels.add("Late Arrival");
        percentages.add(lateDepart);
        labels.add("Late Departure");
        percentages.add(2*PI-(cancelled+diverted+lateArrival+lateDepart));
        labels.add("On Time");
        
        break;
      case "Airports":
        
        
        
        break;
      case "Time":
        float morning = 0;
        float afternoon = 0;
        float evening = 0;
        float night = 0;
        
        for(int i=0;i<data.length;i++)
        {
          int timeOfDay = data.getDep(i).getTime();
          if(timeOfDay >= MORNING && timeOfDay < AFTERNOON) morning++;
          else if (timeOfDay >= AFTERNOON && timeOfDay < EVENING) afternoon++;
          else if (timeOfDay >= EVENING && timeOfDay < NIGHT) evening++;
          else night++;
        }
        
        percentages.add((morning*2*PI)/total);
        labels.add("Morning");
        percentages.add((afternoon*2*PI)/total);
        labels.add("Afternoon");
        percentages.add((evening*2*PI)/total);
        labels.add("Evening");
        percentages.add((night*2*PI)/total);
        labels.add("Night");
        break;
        
    
    }
    return percentages;
  }
  
  void draw()
  {
    float lastAngle = 0;
    for(int i=0; i<angles.size(); i++)
    {
      angle = angles.get(i); 
     
      strokeWeight(3);
      stroke(0);
      float diffColor = map(i,0,angles.size(),0,100);
      fill(red+diffColor,green+diffColor,blue+diffColor);
      arc(x,y,radius,radius,lastAngle,lastAngle+angle,PIE);
      
      float xRect = x+radius*0.75;
      float yRect = y/2+i*height*2;
      
      
      rect(xRect, yRect,height,width);
      textSize(height);
      text(labels.get(i),xRect+radius/2,yRect+height/2);

      lastAngle += angle;
    }
  }
}
