// create PieChart class to show percentage of cancelled/diverted flights

class PieChart
{
  final int HALF_HOUR = 30;
  final float KEY_HEIGHT;
  
  int x,y,radius,height,width;
  float angle; // angle in radians
  PFont font;
  
  int red,green,blue;
  
  Data data;
  ArrayList<Float> angles;
  ArrayList<String> labels;
  
  String flightCarrier;
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
    
    angles = new ArrayList<Float>();
    angles = percentages();
    
    KEY_HEIGHT = x+radius*0.75;
    
    
    //colorMode(HSB,360,100,100);
    this.red = red;
    this.green = green;
    this.blue = blue;
    
    font = loadFont("LucidaSans-Typewriter-20.vlw");
    labels = new ArrayList<>();
    labels.add("Cancelled");
    labels.add("Diverted");
    labels.add("Late Arrivals");
    labels.add("Late Departures");
    labels.add("On Time");
    
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
    println(cancelled,diverted,lateArrival,lateDepart);

    percentages.add(cancelled);
    percentages.add(diverted);
    percentages.add(lateArrival);
    percentages.add(lateDepart);
    percentages.add(2*PI-(cancelled+diverted+lateArrival+lateDepart));
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
      textFont(font,height);
      text(labels.get(i),xRect+radius/2,yRect+height/2);
      
      
      lastAngle += angle;
    }
  }
}
