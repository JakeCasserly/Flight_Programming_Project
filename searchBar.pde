// Jake Casserly's code for searchBar 20/03/2024

class searchBar {
  
  float x, y, width, height;
  String label;
  color widgetColor, labelColor, borderColor;
  
  private String result;
  private boolean blank;
  
  public searchBar(float x, float y, float width, float height, String label, color widgetColor, String result, boolean blank) 
  {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.label = label;
    this.widgetColor = widgetColor;
    labelColor = color(0);
    this.result = result;
    this.blank = blank;
  }
  
  void display() 
  {
    strokeWeight(5);
    stroke(borderColor);
    fill(widgetColor);
    rect(x, y, width, height, 15);
    fill(labelColor);
    textAlign(CENTER, CENTER);
    text(label, x + width / 2, y + height / 2);
    textSize(50);
  }
  
  void adjustText(searchBar theSearchBar) {
    if (theSearchBar.checkMouseSearchBar(mouseX, mouseY) && blank == false) {
      theSearchBar.label = "";
      blank = true;
    }
    if(keyPressed) {
        label += key;
        //print(key);
    }
  }
  
  boolean checkMouseSearchBar(float mx, float my) {
    if (mx > x && mx < x + width && my > y && my < y + height) 
    {
      return true;
    }
    return false;
  }
  
  void result() {
     result = label;
      
      //String[] allStates = {"AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL",
      //"IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ",
      //"NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA",
      //"WV","WI","WY"};
      
      if (label != "type text here...") {
        if (!result.contains("f#")) {
          int amountInThisState = 0;
          
          Table table = loadTable("flights_full.csv", "header");
          
          for(TableRow row:table.rows()) {
            String state = row.getString("ORIGIN_STATE_ABR");
            if (state.equals(result.toUpperCase())) {
              amountInThisState++;
            }
          }
          
          print(amountInThisState);
          println("Request fulfilled");
        }
        else {          
          Table table = loadTable("flights_full.csv", "header");
          
          for(TableRow row:table.rows()) {
            String flightnum = row.getString("MKT_CARRIER_FL_NUM");
            if (flightnum == (String)result.substring(2)) {
              //print(row.getString("ORIGIN_STATE_ABR"));
            }
            //println(flightnum + " " + (String)result.substring(2));
          }
          println(result.substring(2));
          println("Request fulfilled");
        }
      }
  }
  void keyPressed() {
      theSearchBar.adjustText(theSearchBar);
   }
 }
