WidgetList widgetList;
WidgetList widgetList1;
WidgetList widgetList2;
WidgetList widgetList3;
WidgetList widgetList4;
PImage globe;
PImage planeSymbol;
final int homeScreen = 0;
final int flightScreen = 1;
final int divertedScreen = 2;
final int cancelledScreen = 3;
final int heatMapScreen = 4;
final int barChartScreen = 5;
final int pieChartScreen = 6;
final int loadingFrameAmount = 64;
PImage[] loadingGif = new PImage[loadingFrameAmount];
int count = 0;
HeatMap theHeatMap;
PShape theUSImage;
searchBar theSearchBar;
searchBar theChartSearchBar;
boolean searchBarActive;
barChart theBarChart;
String barChartLabel;
String barChartLabel2;
Data flightData;
PieChart thePieChart;
diverted diverted;
searchBar divertedSearchBar;
ControlP5 cp5;
ExecutorService executorService;
readDataTask readInTheData;

void setup() 
{
  executorService = Executors.newCachedThreadPool();
  readInTheData = new readDataTask("readAllData!");
  flightData = new Data("flights_full.csv");
  //flightData.setData();
  executorService.execute(readInTheData);
  cp5 = new ControlP5(this);
  theBarChart = new barChart(100, 130, 40, 40, "flights_full.csv", cp5);
  executorService.execute(theBarChart.readTimes);
  executorService.execute(theBarChart.readStates);
  barChartLabel = "Change to State";
  barChartLabel2 = "Departures";
  globe = loadImage("BG Pic.jpg");
  planeSymbol = loadImage("Plane Symbol.png");
  theUSImage = loadShape("theUS.svg");
  theHeatMap = new HeatMap(200, 264, theUSImage, "flights_full.csv");
  diverted = new diverted(100, 130, flightData);
  size(1512, 982);
   // for loop to load in array of image frames for loading gif
  for (int i = 0; i < loadingFrameAmount; i++) 
    {
      String frameName = "frame_"+ nf(i, 3) +"_delay-0.03s.gif";
      loadingGif[i] = loadImage(frameName);
    }
  widgetList = new WidgetList();
  widgetList.addButton("Flights", color(255, 255, 0), flightScreen);
  widgetList.addButton("Diverted Flights", color(255, 255, 0), divertedScreen);
  //widgetList.addButton("Cancelled Flights", color(255, 255, 0), cancelledScreen);
  widgetList1 = new WidgetList();
  widgetList1.addFlightScreenButton("Main Menu", color(255, 255, 0), homeScreen);
  widgetList1.addFlightScreenButton("Bar Chart", color(255, 255, 0), barChartScreen);
  widgetList1.addFlightScreenButton("Pie Chart", color(255, 255, 0), pieChartScreen);
  //widgetList1.addFlightScreenButton("List", color(255, 255, 0), 1);
  widgetList1.addFlightScreenButton("Heat Map", color(255, 255, 0), 4);
  widgetList2 = new WidgetList();
  widgetList2.addFlightScreenButton("Main Menu", color(255, 255, 0), homeScreen);
  widgetList3 = new WidgetList();
  widgetList3.addFlightScreenButton("Main Menu", color(255,255,0), homeScreen);
  theSearchBar = new searchBar(1280, 95, 210, 70, "type text here...", color(210, 210, 0), "null", false);
  theChartSearchBar = new searchBar(1230, 700, 200, 70, "type text here...", color(210, 210, 0), "null", false);
  divertedSearchBar = new searchBar(1200, 150, 210, 70, "type text here...", color(210, 210, 0), "null", false);
  widgetList4 = new WidgetList();
  widgetList4.addBarChartButton(barChartLabel, color(255,255,0), barChartScreen);
  widgetList4.addBarChartButton(barChartLabel2, color(255,255,0), barChartScreen);
  searchBarActive = false;
  thePieChart = new PieChart(400, 500, 600, flightData, 40, 50, 60);
}

void draw() 
{
  if(count == homeScreen)
  {
    background(0);
    widgetList.display();
    fill(255, 255, 0);
    textSize(75);
    text("Flight Visualiser", (width / 2) + 35, 100);
    textSize(50);
    image(globe, 0, 732, 1512, 250);
    image(planeSymbol, width / 2 - 305, 65, 75, 75);
  }
  else if(count == flightScreen)
  {
    background(0);
    textSize(25);
    widgetList1.display();
  }
  else if (count == heatMapScreen) 
  {
    background(255, 255, 0);
    textSize(25);
    widgetList1.display();
    theHeatMap.draw();
    theHeatMap.drawStates();
    theSearchBar.display();
    if(searchBarActive)
    {
      theSearchBar.adjustText();
    }
  }
  else if (count == barChartScreen)
  {
    background(255, 255, 0);
    textSize(25);
    widgetList1.display();
    theBarChart.draw();
    textSize(25);
    widgetList4.display();
    theChartSearchBar.display();
    if(searchBarActive)
    {
      theChartSearchBar.adjustText();
    }
  }
  else if (count == pieChartScreen)
  {
    background(255, 255, 0);
    widgetList1.display();
    thePieChart.draw();
  }
  else if(count == divertedScreen)
  {
    diverted.draw();
    if(divertedSearchBar.active)
    {
      divertedSearchBar.adjustText();
    }
  }
  else if(count == cancelledScreen)
  {
    background(0);
    widgetList3.display();
  }
  if ( count != barChartScreen ) {
    theBarChart.d1.setVisible(false);
    theBarChart.d2.setVisible(false);
    theBarChart.d3.setVisible(false);
    theBarChart.d4.setVisible(false);
  }
}

void mouseMoved()
{
  widgetList.checkButtonsBorder(mouseX, mouseY);
  widgetList1.checkButtonsBorder(mouseX, mouseY);
  widgetList2.checkButtonsBorder(mouseX, mouseY);
  widgetList3.checkButtonsBorder(mouseX, mouseY);
  widgetList4.checkButtonsBorder(mouseX, mouseY);
  theSearchBar.checkBorder(mouseX, mouseY);
  divertedSearchBar.checkBorder(mouseX, mouseY);
}

void mousePressed() 
{
  if(count == homeScreen)
  {
    widgetList.checkButtons(mouseX, mouseY);
  }
  else if(count == flightScreen || count == heatMapScreen || count == barChartScreen || count == pieChartScreen)
  {
    widgetList1.checkButtons(mouseX, mouseY);
  }
  else if(count == divertedScreen)
  {
    widgetList2.checkButtons(mouseX, mouseY);
  }
  else if(count == cancelledScreen)
  {
    widgetList3.checkButtons(mouseX, mouseY);
  }
  if(count == barChartScreen)
  {
    widgetList4.checkButtons(mouseX, mouseY);
  }
  if (theSearchBar.checkSearchBar(mouseX, mouseY)) {
    theSearchBar.result();
  }
  if (theChartSearchBar.checkSearchBar(mouseX, mouseY)) {
    theChartSearchBar.result();
    println(searchBarActive);
  }
  if (divertedSearchBar.checkSearchBar(mouseX, mouseY)) {
    divertedSearchBar.result();
  }
  if(widgetList4.checkBarChartButton(mouseX, mouseY, 1220, 110) && count == barChartScreen)
  {
    println(barChartLabel2);
    if (barChartLabel == "Change to Time" || barChartLabel == "Change to State") {
      if(theBarChart.xAxis == "state")
      {
        theBarChart.xAxis = "time";
      }
      else
      {
        theBarChart.xAxis = "state";
      }
      if(barChartLabel == "Change to Time")
      {
        widgetList4.setBarChartButtonLabel("Change to State", 1);
        barChartLabel = "Change to State";
      }
      else
      {
        widgetList4.setBarChartButtonLabel("Change to Time", 1);
        barChartLabel = "Change to Time";
      }
    }
  }
    
  if(widgetList4.checkBarChartButton(mouseX, mouseY, 1220, 200) && count == barChartScreen) {
    if (barChartLabel2 == "Arrivals" || barChartLabel2 == "Departures") {
      if(theBarChart.departures == true)
      {
        theBarChart.departures = false;
        println("heremm");
      }
      else
      {
        theBarChart.departures = true;
        println("heremmtrue");
      }
      if(barChartLabel2 == "Arrivals")
      {
        widgetList4.setBarChartButtonLabel("Departures", 2);
        barChartLabel2 = "Departures";
      }
      else
      {
        widgetList4.setBarChartButtonLabel("Arrivals", 2);
        barChartLabel2 = "Arrivals";
      }
    }
  }
  if(theSearchBar.checkSearchBar(mouseX, mouseY))
  {
    searchBarActive = true;
  }
  if(theChartSearchBar.checkSearchBar(mouseX, mouseY))
  {
    searchBarActive = true;
  }
  if(divertedSearchBar.checkSearchBar(mouseX, mouseY))
  {
    searchBarActive = true;
  }
  
  // N.Cunningham added events for PieChart radio buttons 23:00 09/04/24 
  if(thePieChart.radioTime.checkMouse(mouseX,mouseY)) thePieChart.query = thePieChart.SHOW_TIME;
  else if(thePieChart.radioScheduled.checkMouse(mouseX,mouseY)) thePieChart.query = thePieChart.SHOW_SCHEDULED;
  
}

void controlEvent(ControlEvent theEvent) {
    // DropdownList is of type ControlGroup.
    // A controlEvent will be triggered from inside the ControlGroup class.
    // therefore you need to check the originator of the Event with
    // if (theEvent.isGroup())
    // to avoid an error message thrown by controlP5.
  
    if (theEvent.isGroup())
    {
       // to avoid an error message thrown by controlP5.
       println(theEvent.getValue());
       theBarChart.state1 = theBarChart.allStates[(int)theEvent.getValue()];
       
       
       print(theBarChart.state1);
    }
    
    if (theEvent.isFrom(theBarChart.d1)) {
       theBarChart.state1 = theBarChart.allStates[(int)theEvent.getValue()];
       theBarChart.state1num = (int)theEvent.getValue();
    }
    else if (theEvent.isFrom(theBarChart.d2)) {
       theBarChart.state2 = theBarChart.allStates[(int)theEvent.getValue()];
       theBarChart.state2num = (int)theEvent.getValue();
    }
    else if (theEvent.isFrom(theBarChart.d3)) {
       //theBarChart.time1 = theBarChart.allStates[(int)theEvent.getValue()];
       theBarChart.time1num = (int)theEvent.getValue();
    }
    else if (theEvent.isFrom(theBarChart.d4)) {
       //theBarChart.time1 = theBarChart.allStates[(int)theEvent.getValue()];
       theBarChart.time2num = (int)theEvent.getValue();
    }
    
    
    if (theEvent.isController()) {
      println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
    }
  }
