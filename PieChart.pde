// create PieChart class to show percentage of cancelled/diverted flights
import java.util.concurrent.Executors;
import java.util.concurrent.ExecutorService;

class PieChart
{
  final int HALF_HOUR = 30;
  
  int x,y,radius,height,width;
  float angle; // angle in radians
  PFont font;
  
  int hue,saturation,brightness;
  
  Data data;
  ArrayList<Float> angles;
  ArrayList<String> labels;

  String flightCarrier;
  readDataTask readPie;
  ExecutorService executorService = Executors.newCachedThreadPool();
  
// color in HSB - initialize hue
  PieChart(int x, int y, int radius, Data data, int hue)
  {
    this.x = x;
    this.y = y;
    this.radius = radius;
    height = radius/10;
    width = radius/10;
    this.data = data;
    
    angles = new ArrayList<Float>();
    angles = percentages();
    
    //colorMode(HSB,360,100,100);
    this.hue = hue;
    brightness = 90;
    saturation = 100;
    
    font = loadFont("LucidaSans-Typewriter-20.vlw");
    labels = new ArrayList<>();
    labels.add("Cancelled");
    labels.add("Diverted");
    labels.add("Late Arrivals");
    labels.add("Late Departures");
    labels.add("On Time");
    /*
    * Jake's Code for PieChart class:
    * Implemented a thread to help load in the data
    * such that the pressure is taken off of setup
    */
    readPie = new readDataTask("PieChart", flightCarrier, data);
    executorService.execute(readPie);
  }
  
  ArrayList<Float> percentages()
  {
    ArrayList percentages = new ArrayList<Float>();
    float total = data.length;
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
    
    percentages.add(cancelled);
    percentages.add(diverted);
    percentages.add(lateArrival);
    percentages.add(lateDepart);
    percentages.add(2*PI-(cancelled+diverted+lateArrival+lateDepart));
    return percentages;
  }
  
  void draw()
  {
    //angles = percentages();
    float lastAngle = 0;
    int i = 0;
    for(Float angle: angles)
    {
      float saturation = map(i,0,angles.size(),0,100);
      fill(hue,saturation,brightness);
      arc(x,y,radius,radius,lastAngle,lastAngle+angle,PIE);
      rect(x+radius*0.75, y+i*height,height/2,width/2);
      textFont(font,height/2);
      text(labels.get(i),x+radius*0.75+1.5*width,y+i*height+height);
      lastAngle += angle;
      i++;
    }
  }
}
