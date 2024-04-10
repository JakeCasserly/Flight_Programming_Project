/*// cancelled Flight

class CancelledFlights {
  
  int cancld;
  ArrayList<ArrayList<String>> cancelledArrayList = new ArrayList<>();
  int numCncld = 0;
  int arrayRow = 0;
  String date, carrier, carrierFlNum, origin, originCity, originState, originWAC, dest, destCity, destState, destWAC, crsDepTime, crsArrTime, dist;
  
  
  CancelledFlights (Data data)
  {
    
    int row = 1;
    
    while ( row <= data.length)
    {
        cancld = data.getEntry(row).getInt("CANCELLED");
        if(cancld == 1)
        {
          
          numCncld = numCncld + 1;
          
          date = data.getEntry(row).getString("FL_DATE");
          carrier = data.getEntry(row).getString("MKT_CARRIER");
          carrierFlNum = data.getEntry(row).getString("MKT_CARRIER_FL_NUM");
          origin = data.getEntry(row).getString("ORIGIN");
          originCity = data.getEntry(row).getString("ORIGIN_CITY_NAME");
          originState = data.getEntry(row).getString("ORIGIN_STATE_ABR");
          originWAC = data.getEntry(row).getString("FL_DATE");
          dest = data.getEntry(row).getString("DEST");
          destCity = data.getEntry(row).getString("DEST_CITY");
          destState = data.getEntry(row).getString("DEST_STATE_ABR");
          destWAC = data.getEntry(row).getString("DEST_WAC");
          crsDepTime = timeFormat(data.getEntry(row).getInt("CRS_DEP_TIME"));
          crsArrTime = timeFormat(data.getEntry(row).getInt("CRS_ARR_TIME"));
          dist = data.getEntry(row).getString("DISTANCE");
          
          cancelledArrayList.add(new ArrayList<>());
          
          cancelledArrayList.get(arrayRow).add(date);
          cancelledArrayList.get(arrayRow).add(carrier);
          cancelledArrayList.get(arrayRow).add(carrierFlNum);
          cancelledArrayList.get(arrayRow).add(origin);
          cancelledArrayList.get(arrayRow).add(originCity);
          cancelledArrayList.get(arrayRow).add(originState);
          cancelledArrayList.get(arrayRow).add(originWAC);
          cancelledArrayList.get(arrayRow).add(dest);
          cancelledArrayList.get(arrayRow).add(destCity);
          cancelledArrayList.get(arrayRow).add(destState);
          cancelledArrayList.get(arrayRow).add(destWAC);
          cancelledArrayList.get(arrayRow).add(crsDepTime);
          cancelledArrayList.get(arrayRow).add(crsArrTime);
          cancelledArrayList.get(arrayRow).add(dist);
          
          arrayRow = arrayRow + 1;
          
          
        }
        
        row = row + 1;
    }
    
  }
  
  String timeFormat(int time)
  {
    int hours = time/100;
    int minutes = time%100;
    return hours+":"+(minutes == 0 ? "00" :minutes);
  }
  
  
  
}
*/


// removed old cancelled flights code as data function called has been changed making it redundant


import java.util.concurrent.Executors;
import java.util.concurrent.ExecutorService;
import controlP5.*;

class CancelledFlights{
  ArrayList<String[]> cancelledFlights;
  int yOffset = 20;
  int lineHeight = 60;
  int title = 85;
  PImage plane;
  Boolean searchBarActive;
  float height;
  int x, y;
  Data data;
  String input;
  readDataTask drawTheList;
  ExecutorService executorService;

CancelledFlights (int x, int y, Data data) {
    this.x = x;
    this.y = y;
    this.data = data;
    cancelledFlights = data.getCancelledFlights();
    plane = loadImage("Plane Symbol.png");
    searchBarActive = false;
    executorService = Executors.newCachedThreadPool();
    drawTheList = new readDataTask("cancelledList");
    executorService.execute(drawTheList);
}

void draw() {
    background(255, 255, 255);
    fill(0); 
    rect(0, 0, width, 85);
    widgetList2.display();
    divertedSearchBar.display();
    textAlign(LEFT, TOP);
    textSize(80); fill(255, 255, 0);
    text("Cancelled Flights", 500, 5);
    image(plane, 800, 100, height/11, width/11);

    if (mousePressed && divertedSearchBar.checkSearchBar(mouseX, mouseY)) {
        divertedSearchBar.active = true;        
    }

    

    if (keyCode == ENTER && divertedSearchBar.active) {
        //String searchResult = searchResult(); // old-code: edited by Jake
        divertedSearchBar.active = true;
        divertedSearchBar.result();
        String searchResult = divertedSearchBar.result;
        filterFlightsByState(searchResult);
        //divertedSearchBar.active = false; 
        println("search" +  searchResult + "blah");
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
    print(divertedSearchBar.active);
    for (String[] flightInfo : cancelledFlights) {
        fill(0);
        int textHeight = ceil(textWidth(flightInfo[0]) / (width - 40)) * lineHeight;
        text(flightInfo[0], 20, yPos, width - 40, textHeight); 
        text(flightInfo[1], 200, yPos, width - 40, textHeight); 
        text(flightInfo[2], 500, yPos, width - 40, textHeight); 
        text(flightInfo[4], 750, yPos, width - 40, textHeight); 
        text(flightInfo[3], 900, yPos, width - 40, textHeight); 
        String flightStatus = "CANCELLED"; fill(250, 5, 5); 
        text(flightStatus, 1000, yPos, width - 40, textHeight);
        yPos += (0.5*textHeight);
    }
}

  

  void keyPressed() {
    divertedSearchBar.adjustText();
  }

  ArrayList<String[]> filterFlightsByState(String state) {
      ArrayList<String[]> filteredFlights = new ArrayList<String[]>();
      for (String[] flightInfo : data.getCancelledFlights()) {
          if (state.equalsIgnoreCase(flightInfo[5])) {
              filteredFlights.add(flightInfo);
          }
      }
      cancelledFlights=filteredFlights;
      return cancelledFlights;
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
