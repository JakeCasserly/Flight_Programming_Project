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
  
  String[] allStates = {"AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL",
      "IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ",
      "NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA",
      "WV","WI","WY"};
      
  
  barChart (int x, int y, double height, double width) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    paramatersSame = false;
    currentData = new Data("flights_full.csv"); // *********
    amountInStates = new ArrayList<>();
    for (int i = 0; i < allStates.length; i++) {
      amountInStates.add(0);
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
    // if x-axis == states (or something of the likes) {
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
    // }
    
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
    int amountInThisState = 0;
    
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
            amountInThisState++;
          }
          amountInStates.add(amountInThisState);
          amountInThisState = 0;
        }
        count++;
      }
    }
  }
  
}
