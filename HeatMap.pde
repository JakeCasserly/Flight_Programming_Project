// HeatMap
// Jake Casserly's code for Heat map using an svg file

class HeatMap {
  int xpos;
  int ypos;
  PShape img;
  Table table;
  int amountInState;
  boolean readInData;
  
  PShape michigan;
  PShape ohio;
  
  HeatMap(int xpos, int ypos, PShape img) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.img = img;
    table = loadTable("flights2k.csv", "header");
    readInData = false;
    michigan = img.getChild("MI");
    ohio = img.getChild("OH");
  }
  
  void draw() {
    
    if (!readInData) {
      for(TableRow row:table.rows()) {
        String state = row.getString("ORIGIN_STATE_ABR");
        if (state.equals("TX")) {
          //println("departed from "+origin);
          println(state + " ");
          amountInState++;
        }
      }
      readInData = true;
      println(amountInState);
      
    }
    
    img.enableStyle();
    noStroke();
    fill(255);
    rect(70,210,1380,720);
    shape(img, 200, 264);
    
    michigan.disableStyle();
    
    fill(200, 20, 50);
    shape(michigan, 200, 264);
    
    ohio.disableStyle();
    
    fill(amountInState, 20, 50);
    shape(ohio, 200, 264);
    
    
    
    
    
  }
}
  
