// HeatMap
// Jake Casserly's code for Heat map 15/03/2024

class HeatMap {
  int xpos;
  int ypos;
  float currentxpos;
  float currentypos;
  PShape img;
  Table table;
  int amountInState;
  int amountInThisState;
  boolean readInData;
  boolean animated;
  ArrayList<Integer> amountInStates;
  int entries;
  PShape stateShape;
  float t;
  int largest;
  ExecutorService executorService = Executors.newCachedThreadPool();
  readDataTask readStates;
  String flightCarrier;
  Data stateData;
  String database;
  String state;
  int count;
  boolean departures;
  
  String[] allStates = {"AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL",
      "IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ",
      "NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA",
      "WV","WI","WY"};
  
  HeatMap(int xpos, int ypos, PShape img, String database) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.database = database;
    currentxpos = 200;
    currentypos = 900;
    this.img = img;
    departures = true;
    //table = loadTable("flights_full.csv", "header");
    readInData = false;
    animated = false;
    amountInStates = new ArrayList<>();
    for (int i = 0; i < allStates.length; i++) {
      amountInStates.add(0);
    }
    //entries = table.getRowCount();
    t = 0;
    largest = 0;
    flightCarrier = "";
    readStates = new readDataTask("stateHeat", flightCarrier, stateData);
    executorService.execute(readStates);
  }
  
  void draw() {
    
    /*
    Initial read in of the data:
    This code loops through the entire dataset and checks
    for the amount of occurances of specific states.
    It then stores the number of occurances of each respective
    state within an ArrayList by the name of "amountInStates".
    */
    
    //if (!readInData) {
      
    //}
    
    entries = count;
    
    if (!animated) {
      animate();
    } else {
      shape(img, 200, 264);
    }
    
    img.enableStyle();
    noStroke();
    fill(255, 255, 0);
    //rect(0,85,1512,900);
    strokeWeight(4);
    stroke(0);
    fill(0);
    text("HeatMap:\n(Concentration of flights per state)", 750, 190);
    line(1260, 280, 1260, 800);
    line(1260, 280, 1283, 280);
    line(1260, 800, 1283, 800);
    text("No.\nflights", 1330, 530);
    fill(0);
    text(largest, 1325, 277);
    text("0", 1310, 790);
    textSize(25);   
    setGradient(1263, 283, 12, 514, color(255,20,50), color(0,20,50), 1);
    
    if (theSearchBar.result != "null") {
        //print(theChartSearchBar.result);
        if (flightCarrier != theSearchBar.result) {
          //prevFlightCarrier = flightCarrier;
          flightCarrier = theSearchBar.result;
          for (int i = 0; i < allStates.length; i++) {
            amountInStates.set(i, 0);
          }
          readStates = new readDataTask("stateHeat", flightCarrier, stateData);
          executorService.execute(readStates);
          count = 0;
      }
    }
  }
  
  void drawStates() {
    String state;
    
    strokeWeight(0.5);
    stroke(255);
    
    for (int i = 0; i < allStates.length; i++) {
      state = allStates[i];
      stateShape = img.getChild(state);
      stateShape.disableStyle();
      if ((((double)amountInStates.get(i)/(entries)) * 2550) >= 255) {
        fill(255, 20, 50);
      }
      else {
        fill((int)(((double)amountInStates.get(i) / (double)entries) * 2550), 10, 27);
      }
      //println((((double)amountInStates.get(i)/(entries)) * 2550)); for testing
      shape(stateShape, currentxpos, currentypos);
      //println((((double)amountInStates.get(i)/(entries)) * 2550));
    }
  }
  
  void animate () {
    if (currentypos < ypos) {
      animated = true;
      currentypos = ypos;
      currentxpos = xpos;
    }
    else {
      currentxpos = (200 + 130 * sin(t) );
      t += 0.097;
      currentypos -= 9.5;
      //print(currentypos);
    }
  }
  
  void readInData() {
    stateData = new Data(database); // *********
    int number = 0;
    for (int i = 0; i < stateData.length; i++) {
          stateData.setData(i);
          if (stateData.code.contains(flightCarrier)) {
            for (int z = 0; z < allStates.length; z++) {
              if (departures) {
                state = stateData.depData.state;
              }
              else {
                state = stateData.arrData.state;
              }
              if (state.equals(allStates[z])) {
                number = amountInStates.get(z);
                amountInStates.set(z, number+1);
              }
            }
            count++;
          }
     }
     largest = 0;
     for (int i = 0; i < amountInStates.size(); i++) {
       if (amountInStates.get(i) > largest) {
         largest = amountInStates.get(i);
         print(largest);
       }
     }
     print(count);
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
}
