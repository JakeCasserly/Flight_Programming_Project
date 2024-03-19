// HeatMap
// Jake Casserly's code for Heat map using an svg file

class HeatMap {
  int xpos;
  int ypos;
  PShape img;
  Table table;
  int amountInState;
  int amountInThisState;
  boolean readInData;
  ArrayList<Integer> amountInStates;
  int entries;
  PShape michigan;
  PShape ohio;
  PShape stateShape;
  
  String[] allStates = {"AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL",
      "IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ",
      "NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA",
      "WV","WI","WY"};
  
  HeatMap(int xpos, int ypos, PShape img) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.img = img;
    table = loadTable("flights_full.csv", "header");
    readInData = false;
    michigan = img.getChild("MI");
    ohio = img.getChild("OH");
    amountInStates = new ArrayList<>();
    entries = table.getRowCount();
  }
  
  void draw() {
    
    if (!readInData) {
      for (int i = 0; i < allStates.length; i++) {
        for(TableRow row:table.rows()) {
          String state = row.getString("ORIGIN_STATE_ABR");
          if (state.equals(allStates[i])) {
            //println("departed from "+origin);
            println(state + " ");
            amountInThisState++;
          }
        }
        amountInStates.add(amountInThisState);
        println(amountInStates.get(i));
        amountInThisState = 0;
      }
      readInData = true;
    }
    
    
    
    img.enableStyle();
    noStroke();
    fill(255);
    rect(70,210,1380,720);
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
        fill((int)(((double)amountInStates.get(i) / (double)entries) * 2550), 20, 50);
      }
      shape(stateShape, 200, 264);
      println((((double)amountInStates.get(i)/(entries)) * 2550));
    }
  }
}
