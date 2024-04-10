// create PieChart class to show percentage of cancelled/diverted flights

class PieChart
{
  final int CURRENT =0;
  final int SHOW_SCHEDULED = 1;
  final int SHOW_TIME = 2;
  final int SHOW_AIRPORTS = 3;
  
  final int HALF_HOUR = 30;
  final int MORNING = 500;
  final int AFTERNOON = 1200;
  final int EVENING = 1700;
  final int NIGHT = 2100;
  
  int x,y,radius,height,width;
  float angle; // angle in radians
  PFont font;
  
  int query;
  searchBar pieSearch;
  
  RadioButton radioTime, radioScheduled, radioAirports;
  
  int red,green,blue;
  
  Data data;
  ArrayList<Float> angles;
  ArrayList<String> labels;

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

    query = CURRENT;
    radioScheduled = new RadioButton(x,y+radius*0.75,height,"Scheduled",color(red,green,blue));
    radioTime = new RadioButton(x+radius*0.5,y+radius*0.75,height,"Time",color(red,green,blue));
    radioAirports = new RadioButton(x+radius,y+radius*0.75,height,"Airports",color(red,green,blue));
    pieSearch = new searchBar(1280, 95, 210, 70, "type text here...", color(210, 210, 0), "null", false);

    //colorMode(HSB,360,100,100);
    this.red = red;
    this.green = green;
    this.blue = blue;
    
    angles = new ArrayList<Float>();
    labels = new ArrayList<>();
    percentages();
    
    /*
    * Jake's Code for PieChart class:
    * Implemented a thread to help load in the data
    * such that the pressure is taken off of setup
    */
    readPie = new readDataTask("PieChart");
    executorService.execute(readPie);
  }
  
  void percentages()
  {
    angles.clear();
    labels.clear();
    float total = data.length; 
    
    switch(query)
    {
      default:
      case SHOW_SCHEDULED:
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
    
        angles.add(cancelled);
        labels.add("Cancelled");
        angles.add(diverted);
        labels.add("Diverted");
        angles.add(lateArrival);
        labels.add("Late Arrival");
        angles.add(lateDepart);
        labels.add("Late Departure");
        angles.add(2*PI-(cancelled+diverted+lateArrival+lateDepart));
        labels.add("On Time");
        
        break;
      case SHOW_TIME:
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
        
        angles.add((morning*2*PI)/total);
        labels.add("Morning");
        angles.add((afternoon*2*PI)/total);
        labels.add("Afternoon");
        angles.add((evening*2*PI)/total);
        labels.add("Evening");
        angles.add((night*2*PI)/total);
        labels.add("Night");
        break;
        
      case SHOW_AIRPORTS:
      
        if (pieSearch.result != "null") {
          String state = pieSearch.result;
          
          ArrayList<String> airports = new ArrayList<String>();
          ArrayList<Integer> counts = new ArrayList<Integer>();
          total = 0;
          for(int i=0;i<data.length;i++)
          {
            if(data.getDep(i).getState().equals(state))
            {
              String airport = data.getDep(i).getOrigin();
              if (!airports.contains(airport)) 
              {
                airports.add(airport);
                counts.add(1);
                total++;
              }
              else
              {
                counts.add(counts.get(airports.indexOf(airport))+1,airports.indexOf(airport));
              }
            }
          }
          labels = airports;
          for(int count : counts)
          {
            angles.add(count*2*PI/total);
          }
      }
    }
    query = CURRENT;
  }
  
  void draw()
  {
    println(query);
    if(query==SHOW_AIRPORTS)
    {
      fill(red,green,blue);
      ellipse(x,y,radius,radius);
    }
    else
    {
      if(query!=CURRENT) percentages();
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
    radioTime.draw();
    radioScheduled.draw();
    radioAirports.draw();
    pieSearch.display();
    if (pieSearch.active) {
       pieSearch.adjustText();
    }
  }
}
