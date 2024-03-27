// barChart
// Jake Casserly's code for Bar Chart 20/03/2024
class barChart {
  int x;
  int y;
  double height;
  double width;
  Data currentData;
  boolean paramatersSame;
  int[] yOutputStates;
  ArrayList<Integer> amountInStates;
  String state;
  String flightCarrier;
  String prevFlightCarrier;
  int number;
  float count;
  boolean departures;
  int[] dates;
  ArrayList<Integer> amountOnDate;
  String xAxis;
  
  String[] allStates = {"AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL",
      "IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ",
      "NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA",
      "WV","WI","WY"};
      
  
  barChart (int x, int y, double height, double width) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    xAxis = "state";
    paramatersSame = false;
    currentData = new Data("flights_full.csv"); // *********
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
  }
  
  void draw() {
    
    if (!paramatersSame) {
      readData();
      paramatersSame = true;
    }
    
    fill(255);
    strokeWeight(7);
    line(x, y, x, y+750);
    line(x, y+750, x+1000, y+750);
    strokeWeight(3);
    if(xAxis == "state") {
      for (int i = 0; i < allStates.length; i++) {
        strokeWeight(3);
        stroke(3);                                      // needs to be revised
        line(x+(i*20), y+750, (x-5)+(i*20), y+770);
        textSize(11);
        fill(0);
        text(allStates[i], x+6+(i*20), y+764);
        stroke(1);
        fill(17, 17, 200);
        rect(x+(i*20), y+(750-(amountInStates.get(i)/count)*2000), 20, (amountInStates.get(i)/count)*2000);
      }
      
      // Y-Axis
      for (int i = 0; i < 25; i++) {
        strokeWeight(4);
        line(x, y+750-(i*25), x-8, y+750-(i*25));
      }
      text(Integer.toString((int)((amountInStates.get(10)/count)*2000)), x-40, y+(750-(amountInStates.get(10)/count)*2000));
      line(x, y+(750-(amountInStates.get(10)/count)*2000), x-6, y+(750-(amountInStates.get(10)/count)*2000));
    }
    else if (xAxis == "time") {
      for (int i = 0; i < dates.length; i++) {
        strokeWeight(3);
        stroke(3);                                      // needs to be revised
        line(x+(i*25), y+750, (x-5)+(i*25), y+770);
        textSize(11);
        fill(0);
        text(Integer.toString(i+1), x+6+(i*25), y+764);
        stroke(1);
        fill(17, 17, 200);
        rect(x+(i*25), y+(750-(amountOnDate.get(i)/count)*12000), 20, (amountOnDate.get(i)/count)*12000);
      }
      
      // Y-Axis
      for (int i = 0; i < 25; i++) {
        strokeWeight(4);
        line(x, y+750-(i*25), x-8, y+750-(i*25));
      }
      textSize(20);
      text(Integer.toString((int)((amountOnDate.get(10)/count)*12000)), x-40, y+(750-(amountOnDate.get(10)/count)*12000));
      line(x, y+(750-(amountOnDate.get(10)/count)*12000), x-6, y+(750-(amountOnDate.get(10)/count)*12000));
      
      text(Integer.toString((int)(((amountOnDate.get(10)/count)*12000)/2)), x-40, y+(750-((amountOnDate.get(10)/count)*12000)/2));
      line(x, y+(750-((amountOnDate.get(10)/count)*12000)/2), x-6, y+(750-((amountOnDate.get(10)/count)*12000)/2));
    }
    
    
    //if (!theBarChart.paramatersSame) { // for main
    //  theBarChart.readData();
    //  theBarChart.paramatersSame = true;
    //}
    
    //if (theSearchBar.result != flightCarrier) {
    //  flightCarrier = theSearchBar.result;
    //  paramatersSame = false;
    //}
    
  }
  
  void readData() {
    //int amountInThisState = 0;
    String[] date;
    
    // reads Data for a specific flight carrier state by state
    if (xAxis == "state") {
      for (int i = 0; i < currentData.length; i++) {
        currentData.setData(i);
        if (currentData.code.contains(flightCarrier)) {
          for (int z = 0; z < allStates.length; z++) {
            if (departures) {
              state = currentData.depData.state;
            }
            else {
              state = currentData.arrData.state;
            }
            if (state.equals(allStates[z])) {
              number = amountInStates.get(z);
              amountInStates.set(z, number+1);
            }
          }
          count++;
        }
      }
    }
    else if (xAxis == "time") {
      for (int i = 0; i < currentData.length; i++) {
        currentData.setData(i);
        //if (currentData.code.contains(flightCarrier)) {        // possiblility to restrict it to specific flight carriers
        date = currentData.date.split("/");
        //print(date[1]); testing
        for (int z = 0; z < dates.length; z++) {
          if (Integer.parseInt(date[1]) == dates[z]) {
            number = amountOnDate.get(z);
            amountOnDate.set(z, number+1);
          }
        }
        count++;
      //}
      }
    }
    else {
      // do nothing forever
    }
    
  }
  
}
