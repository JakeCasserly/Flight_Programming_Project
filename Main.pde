WidgetList widgetList;
WidgetList widgetList1;
WidgetList widgetList2;
WidgetList widgetList3;
PImage globe;
PImage planeSymbol;
final int homeScreen = 0;
final int flightScreen = 1;
final int divertedScreen = 2;
final int cancelledScreen = 3;
int count = 0;
HeatMap theHeatMap;
boolean heatMapScreen;
PShape theUSImage;

void setup() 
{
  globe = loadImage("BG Pic.jpg");
  planeSymbol = loadImage("Plane Symbol.png");
  theUSImage = loadShape("theUS.svg");
  theHeatMap = new HeatMap(200, 264, theUSImage);
  heatMapScreen = true;
  size(1512, 982);
  widgetList = new WidgetList();
  widgetList.addButton("Flights", color(255, 255, 0), flightScreen);
  widgetList.addButton("Diverted Flights", color(255, 255, 0), divertedScreen);
  widgetList.addButton("Cancelled Flights", color(255, 255, 0), cancelledScreen);
  widgetList1 = new WidgetList();
  widgetList1.addFlightScreenButton("Main Menu", color(255, 255, 0), homeScreen);
  widgetList1.addFlightScreenButton("Bar Chart", color(255, 255, 0), 1);
  widgetList1.addFlightScreenButton("Pie Chart", color(255, 255, 0), 1);
  widgetList1.addFlightScreenButton("List", color(255, 255, 0), 1);
  widgetList1.addFlightScreenButton("Heat Map", color(255, 255, 0), 1);
  widgetList2 = new WidgetList();
  widgetList2.addFlightScreenButton("Main Menu", color(255, 255, 0), homeScreen);
  widgetList3 = new WidgetList();
  widgetList3.addFlightScreenButton("Main Menu", color(255,255,0), homeScreen);
  //widgetList4 = new WidgetList();
  //widgetList4.addFlightScreenButton("Main Menu", color(255,255,0), homeScreen);
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
    if (heatMapScreen) {
      theHeatMap.draw();
      theHeatMap.drawStates();
    }
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
}

void mousePressed() 
{
  widgetList.checkButtons(mouseX, mouseY);
  widgetList1.checkButtons(mouseX, mouseY);
  widgetList2.checkButtons(mouseX, mouseY);
  widgetList3.checkButtons(mouseX, mouseY);
}
