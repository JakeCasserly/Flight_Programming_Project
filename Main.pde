WidgetList widgetList;
WidgetList widgetList1;
WidgetList widgetList2;
PImage globe;
PImage planeSymbol;
final int homeScreen = 0;
final int flightScreen = 1;
final int cancelledScreen = 2;
final int divertedScreen = 3;
int count = 0;

void setup() 
{
  globe = loadImage("BG Pic.jpg");
  planeSymbol = loadImage("Plane Symbol.png");
  size(1512, 982);
  widgetList = new WidgetList();
  widgetList.addButton("Flights", color(255, 255, 0), 1);
  widgetList.addButton("Diverted Flights", color(255, 255, 0), 2);
  widgetList.addButton("Cancelled Flights", color(255, 255, 0), 3);
  widgetList1 = new WidgetList();
  widgetList1.addFlightScreenButton("Main Menu", color(255, 255, 0), 0);
  widgetList1.addFlightScreenButton("Bar Chart", color(255, 255, 0), 1);
  widgetList1.addFlightScreenButton("Pie Chart", color(255, 255, 0), 1);
  widgetList1.addFlightScreenButton("List", color(255, 255, 0), 1);
  widgetList1.addFlightScreenButton("Heat Map", color(255, 255, 0), 1);
  widgetList2 = new WidgetList();
  widgetList2.addFlightScreenButton("Main Menu", color(255, 255, 0), 0);
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
  else if(count == cancelledScreen)
  {
    background(0);
    widgetList2.display();
  }
  else if(count == divertedScreen)
  {
    background(0);
  }
}
