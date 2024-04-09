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
  readDataTask animate;
  boolean startingThread;
  
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
    readInData = false;
    animated = false;
    startingThread = true;
    amountInStates = new ArrayList<>();
    for (int i = 0; i < allStates.length; i++) {
      amountInStates.add(0);
    }
    t = 0;
    largest = 0;
    flightCarrier = "";
    readStates = new readDataTask("stateHeat");
    executorService.execute(readStates);
    animate = new readDataTask("animateHeatMap");
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
    
    //if (startingThread) {
    //  executorService.execute(animate);
    //  startingThread = false;
    //}
    
    entries = count;
    
    if (!animated) {
       animate();
    }
    else {
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
          readStates = new readDataTask("stateHeat");
          executorService.execute(readStates);
          count = 0;
      }
    }
  }
  
  void drawStates() {
    //img.enableStyle();
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
      shape(stateShape, currentxpos, currentypos);
      fill(255);
      text("WA", currentxpos+245, currentypos+70);
      text("OR", currentxpos+230, currentypos+145);
      text("MT", currentxpos+390, currentypos+105);
      text("WY", currentxpos+410, currentypos+185);
      text("ID", currentxpos+310, currentypos+160);
      text("CA", currentxpos+210, currentypos+290);
      text("AK", currentxpos+220, currentypos+480);
      text("NV", currentxpos+260, currentypos+232);
      text("UT", currentxpos+340, currentypos+256);
      text("AZ", currentxpos+332, currentypos+350);
      text("CO", currentxpos+430, currentypos+270);
      text("NM", currentxpos+420, currentypos+360);
      text("TX", currentxpos+532, currentypos+430);
      text("KS", currentxpos+550, currentypos+285);
      text("OK", currentxpos+570, currentypos+345);
      text("NE", currentxpos+520, currentypos+225);
      text("SD", currentxpos+520, currentypos+165);
      text("ND", currentxpos+520, currentypos+105);
      text("MN", currentxpos+600, currentypos+120);
      text("IA", currentxpos+615, currentypos+210);
      text("MO", currentxpos+637, currentypos+275);
      text("AR", currentxpos+645, currentypos+360);
      text("LA", currentxpos+650, currentypos+420);
      text("MS", currentxpos+698, currentypos+390);
      text("AL", currentxpos+750, currentypos+385);
      text("GL", currentxpos+810, currentypos+380);
      text("FL", currentxpos+850, currentypos+460);
      text("SC", currentxpos+852, currentypos+350);
      text("NC", currentxpos+850, currentypos+305);
      text("TN", currentxpos+740, currentypos+325);
      text("KY", currentxpos+760, currentypos+285);
      text("VA", currentxpos+856, currentypos+263);
      textSize(13);
      text("WV", currentxpos+819, currentypos+250);
      textSize(25);
      text("OH", currentxpos+780, currentypos+220);
      text("IN", currentxpos+732, currentypos+230);
      text("IL", currentxpos+690, currentypos+240);
      text("MI", currentxpos+740, currentypos+160);
      text("WI", currentxpos+660, currentypos+145);
      text("PA", currentxpos+855, currentypos+193);
      text("NY", currentxpos+883, currentypos+145);
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
    }
  }
  
  void readInData() {
    stateData = new Data(database); // *********
    int number = 0;
    String code = "";
    stateData.setData();
    for (int i = 0; i < stateData.length; i++) {
      code = stateData.getCode(i);
          if (code.contains(flightCarrier)) {
            for (int z = 0; z < allStates.length; z++) {
              if (departures) {
                state = stateData.getDep(i).getState();
              }
              else {
                state = stateData.getArr(i).getState();
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
