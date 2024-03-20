// HeatMap
// Jake Casserly's code for Heat map using an svg file

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
  
  String[] allStates = {"AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL",
      "IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ",
      "NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA",
      "WV","WI","WY"};
  
  HeatMap(int xpos, int ypos, PShape img) {
    this.xpos = xpos;
    this.ypos = ypos;
    currentxpos = 200;
    currentypos = 900;
    this.img = img;
    table = loadTable("flights_full.csv", "header");
    readInData = false;
    animated = false;
    amountInStates = new ArrayList<>();
    entries = table.getRowCount();
    t = 0;
  }
  
  void draw() {
    
    if (!readInData) {
      for (int i = 0; i < allStates.length; i++) {
        for(TableRow row:table.rows()) {
          String state = row.getString("ORIGIN_STATE_ABR");
          if (state.equals(allStates[i])) {
            //println("departed from "+origin);
            //println(state + " ");
            amountInThisState++;
          }
        }
        amountInStates.add(amountInThisState);
        println(amountInStates.get(i));
        amountInThisState = 0;
      }
      readInData = true;
    }
    
    if (!animated) {
      animate();
    }
    
    img.enableStyle();
    noStroke();
    fill(255, 255, 0);
    rect(0,180,1512,900);
    shape(img, 200, 264);
    
  }
  
  void drawStates() {
    String state;
    
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
      shape(stateShape, 200, 264);
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
      currentxpos = (200 + 80 * sin(t) );
      t += 0.2382;
      currentypos -= 9.5;
      print(currentypos);
    }
  }
}
