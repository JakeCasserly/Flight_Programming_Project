// Diverted class Rosie Casssidy 09/04
//import controlP5.*;

class diverted{
  ArrayList<String[]> divertedFlights;
  int yOffset = 20;
  int lineHeight = 60;
  int title = 85;
  PImage plane;
  Boolean searchBarActive;
  float height;
  int x, y;
  Data data;
  String input;

diverted (int x, int y, Data data) {
    this.x = x;
    this.y = y;
    this.data = data;
    divertedFlights = data.getDivertedFlights();
    plane = loadImage("Plane Symbol.png");
    searchBarActive = false;
}

void draw() {
    background(255, 255, 255);
    fill(0); 
    rect(0, 0, width, 85);
    widgetList2.display();
    divertedSearchBar.display();
    textAlign(LEFT, TOP);
    textSize(80); fill(255, 255, 0);
    text("Diverted Flights", 500, 5);
    textSize(30); fill(0);
    text("Enter a state code:", 1190, 120);

    if (mousePressed && divertedSearchBar.checkSearchBar(mouseX, mouseY)) {
        divertedSearchBar.active = true;        
    }
    
    if (keyCode == ENTER && divertedSearchBar.active) {
        divertedSearchBar.active = true;
        divertedSearchBar.result();
        String searchResult = divertedSearchBar.result;
        filterFlightsByState(searchResult);
    }
    
    fill(0);
    textAlign(LEFT, TOP);
    textSize(30);
    text("FLIGHT", 20, title+20);
    text("FROM", 200, title+20);
    text("DESTINATION", 500, title+20);
    text("DATE", 750, title+20);
    text("TIME", 900, title+20);
    text("STATUS", 1000, title+20);
    textSize(20); fill(0);
    int yPos = 60 + title;
    for (String[] flightInfo : divertedFlights) {
      fill(0);
      int textHeight = ceil(textWidth(flightInfo[0]) / (width - 40)) * lineHeight;
      text(flightInfo[0], 20, yPos, width - 40, textHeight); 
      text(flightInfo[1], 200, yPos, width - 40, textHeight); 
      text(flightInfo[2], 500, yPos, width - 40, textHeight); 
      text(flightInfo[4], 750, yPos, width - 40, textHeight); 
      text(flightInfo[3], 900, yPos, width - 40, textHeight); 
      String flightStatus = "DIVERTED"; fill(250, 5, 5); 
      text(flightStatus, 1000, yPos, width - 40, textHeight);
      yPos += (0.5*textHeight);
    }
}

  void keyPressed() {
    divertedSearchBar.adjustText();
  }

  ArrayList<String[]> filterFlightsByState(String state) {
      ArrayList<String[]> filteredFlights = new ArrayList<String[]>();
      for (String[] flightInfo : data.getDivertedFlights()) {
          if (state.equalsIgnoreCase(flightInfo[5])) {
              filteredFlights.add(flightInfo);
          }
      }
      divertedFlights=filteredFlights;
      return divertedFlights;
  }
  
  String searchResult() {
    String result = "";
    if (keyPressed && key != ENTER && key != BACKSPACE) {
        result += key;
        keyPressed = false;
    } else if (keyPressed && key == BACKSPACE && result.length() > 0) {
        result = result.substring(0, result.length() - 1);
        keyPressed = false;
    }
    return result;
  }
}
