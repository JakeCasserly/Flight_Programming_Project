// HeatMap
// Jake Casserly's code for Heat map using an svg file

class HeatMap {
  int xpos;
  int ypos;
  PShape img;
  Table table;
  int amountInState;
  boolean readInData;
  
  HeatMap(int xpos, int ypos, PShape img) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.img = img;
    table = loadTable("flights2k.csv", "header");
    readInData = false;
  }
  
  void draw() {
    img.enableStyle();
    noStroke();
    fill(255);
    rect(70,210,1380,720);
    img.setFill(color(20, 50, 123));
    shape(img, 200, 264);
    
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
  }
}
  
