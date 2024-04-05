// barChart
// Jake Casserly's code for Bar Chart 20/03/2024

/**
 * This class generates a barChart of data. 
 * 
 * 
 * @params: x-coordinate (int), y-coordinate (int),
 * height (double), width (double), database (String)
 */

import java.util.concurrent.Executors;
import java.util.concurrent.ExecutorService;
import controlP5.*;

class barChart {
  //ControlP5 cp5;
  //DropdownList d1, d2;
  //cp5 = new ControlP5(this);
  int x;
  int y;
  double height;
  double width;
  Data stateData;
  Data timeData;
  boolean paramatersSame;
  int[] yOutputStates;
  ArrayList<Integer> amountInStates;
  String state;
  String flightCarrier;
  String prevFlightCarrier;
  float count;
  float countTime;
  boolean departures;
  int[] dates;
  ArrayList<Integer> amountOnDate;
  String xAxis;
  String prevxAxis;
  boolean dataRead;
  ExecutorService executorService = Executors.newCachedThreadPool();
  readDataTask readStates;
  readDataTask readTimes;
  boolean readTime;

  String[] allStates = {"AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL",
      "IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ",
      "NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA",
      "WV","WI","WY"};

  barChart (int x, int y, double height, double width, String database) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    xAxis = "time";
    prevxAxis = "time";
    paramatersSame = false;
    readTime = false;
    count = 0;
    countTime = 0;
    stateData = new Data(database); // *********
    timeData = new Data(database);
    amountInStates = new ArrayList<>();
    dates = new int[30];
    amountOnDate = new ArrayList<>();
    for (int i = 0; i < allStates.length; i++) {
      amountInStates.add(0);
    }
    for (int i = 0; i < dates.length; i++) {
      dates[i] = i+1;
    }
    for (int i = 0; i < dates.length; i++) {
      amountOnDate.add(0);
    }
    departures = true;
    flightCarrier = "B6";
    prevFlightCarrier = "B6";
    readStates = new readDataTask("state", flightCarrier, stateData);
    readTimes = new readDataTask("time", flightCarrier, timeData);
    executorService.execute(readTimes);
    executorService.execute(readStates);
  }

  void draw() {

    if (!paramatersSame) {           // initial read of the data
      //readData();
      System.out.println("Starting Executor");

      


      // Start each individual task (i.e. you've created the task objects, 
      // now you just want to run them on individual threads
      // which the executor will handle for you by using a "ThreadPool")

      //executorService.shutdown();                                                                                  // this is used to shut down the threads
      paramatersSame = true;
    }

    //if (prevxAxis != xAxis) {                                                                                        // if the xAxis variable is changed, re-read the data
    //  readData();
    //  executorService.execute(readStates);
      //prevxAxis = xAxis;
    //}

    fill(255);
    strokeWeight(7);
    line(x, y, x, y+750);                                                                                            // draw the x-Axis and y-Axis:
    line(x, y+750, x+1000, y+750);
    strokeWeight(3);
    if(xAxis == "state") {                                                                                           // if the x-Axis is meant to display states, then display states, else display time
      for (int i = 0; i < allStates.length; i++) {
        strokeWeight(3);
        stroke(3);
        line(x+(i*20), y+750, (x-5)+(i*20), y+770);
        fill(0);
        textSize(30);
        text("BarChart:\n(Concentration of flights per state)", 750, 175);
        textSize(19);
        text("States/(state abreviation)", 560, 925);
        textSize(11);
        fill(0);
        text(allStates[i], x+6+(i*20), y+764);
        stroke(1);
        fill(17, 17, 200);
        //rect(x+(i*20), y+(750-(amountInStates.get(i)/count)*2000), 20, (amountInStates.get(i)/count)*2000);
        setGradient((int)x+(i*20), (int)(y+(750-(amountInStates.get(i)/count)*2500)), (float)20, (float)((amountInStates.get(i)/count)*2500), (int)color(255,20,50), (int)color(0,20,50), 1);
      }

      // Y-Axis
      for (int i = 0; i < 25; i++) {
        strokeWeight(4);
        line(x, y+750-(i*25), x-8, y+750-(i*25));
      }
      text(amountInStates.get(8), x-40, y+(750-(amountInStates.get(8)/count)*2500));
      line(x, y+(750-(amountInStates.get(8)/count)*2500), x-6, y+(750-(amountInStates.get(8)/count)*2500));
      
      textSize(32);
      text(allStates[2], x+1120, 800);
      text(allStates[4], x+1320, 800);
      fill(200, 20, 25);
      //print((float)amountInStates.get(2)/((float)amountInStates.get(2)+amountInStates.get(4)) + " "); testing
      //print((float)((amountInStates.get(2)/(amountInStates.get(2)+amountInStates.get(4)))*100)); testing
      strokeWeight(1);
      rect(x+1110, 850, (((float)amountInStates.get(2)/((float)amountInStates.get(2)+amountInStates.get(4)))*220), 25);
      fill(100, 220, 20);
      rect(x+1110+(((float)amountInStates.get(2)/((float)amountInStates.get(2)+amountInStates.get(4)))*220), 850, ((1-((float)amountInStates.get(2)/((float)amountInStates.get(2)+amountInStates.get(4))))*220), 25);
      
      //fill(120);
      //rect(x+1120, 850, 0.2*100, 25);
      //fill(255);
      //rect(x+1120 + 0.2*100, 850, (1-0.2)*100, 25);
    }
    else if (xAxis == "time") {
      for (int i = 0; i < dates.length; i++) {
        strokeWeight(3);
        stroke(3);                                                                                                     // needs to be revised
        line(x+(i*25), y+750, (x-5)+(i*25), y+770);
        fill(0);
        textSize(30);
        text("BarChart:\n(Flights sorted by dates)", 750, 190);                                                        // text to be displayed for user to see description of data being displayed
        textSize(19);
        text("Dates/(day in the month)", 480, 925);
        textSize(11);
        fill(0);
        text(Integer.toString(i+1), x+6+(i*25), y+764);
        stroke(1);
        fill(17, 17, 200);
        rect(x+(i*25), y+(750-(amountOnDate.get(i)/countTime)*12000), 20, (amountOnDate.get(i)/countTime)*12000);      // for each rectangle, draw it from the top of the rectangle, which should be 750 - height.
      }                                                                                                                // inherintly the user will see the rectangle drawn from the bottom, when actually it is drawn
      // as usual from the top left.
      // Y-Axis
      for (int i = 0; i < 25; i++) {
        strokeWeight(4);
        line(x, y+750-(i*25), x-8, y+750-(i*25));
      }
      textSize(20);
      text(amountOnDate.get(10), x-40, y+(750-(amountOnDate.get(10)/countTime)*12000));                                // give some idea of the scale of the data
      line(x, y+(750-(amountOnDate.get(10)/countTime)*12000), x-6, y+(750-(amountOnDate.get(10)/countTime)*12000));    // to be displayed on the y-axis

      text(amountOnDate.get(10)/2, x-40, y+(750-((amountOnDate.get(10)/countTime)*12000)/2));
      line(x, y+(750-((amountOnDate.get(10)/countTime)*12000)/2), x-6, y+(750-((amountOnDate.get(10)/countTime)*12000)/2));
    }

    //if (theSearchBar.result != flightCarrier) {
    //  flightCarrier = theSearchBar.result;
    //  paramatersSame = false;
    //}

    if (theChartSearchBar.result != "null") {
      if (theChartSearchBar.result != "state" && theChartSearchBar.result != "time"){
        //print(theChartSearchBar.result);
        //print(flightCarrier);
        if (flightCarrier != theChartSearchBar.result) {
          //prevFlightCarrier = flightCarrier;
          flightCarrier = theChartSearchBar.result;
          for (int i = 0; i < allStates.length; i++) {
            amountInStates.set(i, 0);
          }
          //readStates.setRunning();
          readStates = new readDataTask("state", flightCarrier, stateData);
          executorService.execute(readStates);
          count = 0;
          //print("something");
        }
      }
      else if (theSearchBar.result == "state" || theSearchBar.result == "time"){
        xAxis = theSearchBar.result;
        readData();
      }
      else {
        // do nothing forever
      }
    }

  }

  void readData() {
    //int amountInThisState = 0;
    //String[] date;

    //// reads Data for a specific flight carrier state by state
    //if (xAxis == "state") {
    //  for (int i = 0; i < currentData.length; i++) {
    //    currentData.setData(i);
    //    if (currentData.code.contains(flightCarrier)) {
    //      for (int z = 0; z < allStates.length; z++) {
    //        if (departures) {
    //          state = currentData.depData.state;
    //        }
    //        else {
    //          state = currentData.arrData.state;
    //        }
    //        if (state.equals(allStates[z])) {
    //          number = amountInStates.get(z);
    //          amountInStates.set(z, number+1);

    //        }
    //      }
    //      count++;
    //    }
    //    //print("test");
    //  }
    //  dataRead = true;
    //}
    //else if (xAxis == "time") {
    //  for (int i = 0; i < currentData.length; i++) {
    //    currentData.setData(i);
    //    //if (currentData.code.contains(flightCarrier)) {        // possiblility to restrict it to specific flight carriers
    //    date = currentData.date.split("/");
    //    //print(date[1]); testing
    //    for (int z = 0; z < dates.length; z++) {
    //      if (Integer.parseInt(date[1]) == dates[z]) {
    //        number = amountOnDate.get(z);
    //        amountOnDate.set(z, number+1);
    //      }
    //    }
    //    count++;
    //  //}
    //  }
    //}
    //else {
    //  // do nothing forever
    //}

  }

  void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

    noFill();

    if (axis == 1) {  // Top to bottom gradient
      for (int i = y; i <= y+h; i++) {
        float inter = map(i, y, y+h, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(x, i, x+w, i);
      }
    }  
    else if (axis == 2) {  // Left to right gradient
      for (int i = x; i <= x+w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(i, y, i, y+h);
      }
    }
  }

  void mousePressed() {

  }

}
