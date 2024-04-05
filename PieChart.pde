// create PieChart class to show percentage of cancelled/diverted flights??
import java.util.concurrent.Executors;
import java.util.concurrent.ExecutorService;

class PieChart
{
  int x,y,radius,height,width;
  float angle; // angle in radians
  PFont font;
  Data data;
  ArrayList<Float> angles;
  ArrayList<Integer> colors;
  ArrayList<String> labels;
  String flightCarrier;
  readDataTask readPie;
  ExecutorService executorService = Executors.newCachedThreadPool();
  
  PieChart(int x, int y, int radius, Data data)
  {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.data = data;
    height = radius/10;
    width = radius/10;
    //font = loadFont("LucidaSans-Typewriter-20.vlw");
    angles = new ArrayList<Float>();
    colors = new ArrayList<Integer>();
    labels = new ArrayList<>();
    colors.add(#F0D285);
    colors.add(#85CDF0);
    labels.add("Cancelled");
    labels.add("Diverted");
    
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
    //float arriveOnTime = 0;
    //float departOnTime = 0;
    
    for(int i=0;i<data.length;i++)
    {
      data.setData(i);
      if(data.cancelled == true) cancelled++;
      if(data.diverted == true) diverted++;
      //if(data.arrData.time == data.arrData.crs) arriveOnTime++;
      //if(data.depData.time == data.depData.crs) departOnTime++;
    }
    cancelled /= total;
    diverted /= total;
    //arriveOnTime /= total;
    //departOnTime /= total;
    //println(cancelled,diverted);
    percentages.add(cancelled*2*PI);
    percentages.add(diverted*2*PI);
    //percentages.add(arriveOnTime*2*PI);
    //percentages.add(departOnTime*2*PI);
    return percentages;
  }
  
  void draw()
  {
    fill(#9585F0);
    ellipse(x,y,radius,radius);
    //angles = percentages();
    float lastAngle = 0;
    int i = 0;
    for(Float angle: angles)
    {
      fill(colors.get(i));
      arc(x,y,radius,radius,lastAngle,lastAngle+angle,PIE);
      rect(x+radius*0.75, y-i*radius*0.5,height,width);
      //textFont(font,height);
      text(labels.get(i),x+radius*0.75+1.5*width,y-i*radius*0.5+height);
      lastAngle = angle;
      i++;
    }
    
    // create labels
    //rect(x+radius*0.75,y-radius*0.5,height,width);
    //textFont(font,height);
    //text("Cancelled",x+radius*0.75+1.5*width,y-radius*0.5+height);
  }
}
