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
Data flightData;
PieChart thePieChart;

void setup() 
{
  flightData = new Data("flights_full.csv");
  barChartLabel = "Change to Time";
  globe = loadImage("BG Pic.jpg");
  planeSymbol = loadImage("Plane Symbol.png");
  theUSImage = loadShape("theUS.svg");
  theHeatMap = new HeatMap(200, 264, theUSImage);
  theBarChart = new barChart(100, 130, 40, 40, "flights_full.csv");
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
  widgetList.addButton("Cancelled Flights", color(255, 255, 0), cancelledScreen);
  widgetList1 = new WidgetList();
  widgetList1.addFlightScreenButton("Main Menu", color(255, 255, 0), homeScreen);
  widgetList1.addFlightScreenButton("Bar Chart", color(255, 255, 0), barChartScreen);
  widgetList1.addFlightScreenButton("Pie Chart", color(255, 255, 0), pieChartScreen);
  widgetList1.addFlightScreenButton("List", color(255, 255, 0), 1);
  widgetList1.addFlightScreenButton("Heat Map", color(255, 255, 0), 4);
  widgetList2 = new WidgetList();
  widgetList2.addFlightScreenButton("Main Menu", color(255, 255, 0), homeScreen);
  widgetList3 = new WidgetList();
  widgetList3.addFlightScreenButton("Main Menu", color(255,255,0), homeScreen);
  theSearchBar = new searchBar(1280, 95, 210, 70, "type text here...", color(210, 210, 0), "null", false);
  theChartSearchBar = new searchBar(1280, 600, 200, 70, "type text here...", color(210, 210, 0), "null", false);
  widgetList4 = new WidgetList();
  widgetList4.addBarChartButton(barChartLabel, color(255,255,0), barChartScreen);
  searchBarActive = false;
  thePieChart = new PieChart(400, 500, 600, flightData);
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
    background(0);
    widgetList2.display();
  }
  else if(count == cancelledScreen)
  {
    background(0);
    widgetList3.display();
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
  theSearchBar.result();
  theChartSearchBar.result();
  if(widgetList4.checkBarChartButton(mouseX, mouseY) && count == barChartScreen)
  {
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
      widgetList4.setBarChartButtonLabel("Change to State");
      barChartLabel = "Change to State";
    }
    else
    {
      widgetList4.setBarChartButtonLabel("Change to Time");
      barChartLabel = "Change to Time";
    }
  }
  if(theSearchBar.checkSearchBar(mouseX, mouseY))
  {
    searchBarActive = true;
  }
}
