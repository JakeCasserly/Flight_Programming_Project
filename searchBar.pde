// Jake Casserly's code for searchBar 20/03/2024

class searchBar {
  
  float x, y, width, height;
  String label;
  color widgetColor, labelColor, borderColor;
  private boolean active;
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
    this.blank = false;
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
  
  void adjustText() 
  {
      if (!blank) 
      {
        label = "";
        blank = true;
      }
      if (keyPressed) 
      {
        if (key != ENTER && key != BACKSPACE) 
        {
          label += key;
        } 
        else if (key == BACKSPACE && label.length() > 0) 
        {
          label = label.substring(0, label.length() - 1);
        }
        keyPressed = false;
      }
  }
  
  boolean checkSearchBar(float mx, float my)
  {
    if (mx > x && mx < x + width && my > y && my < y + height)
    {
      return true;
    }
    return false;
  }
  
  boolean checkBorder(float mx, float my)
  {
    if (mx > x && mx < x + width && my > y && my < y + height)
    {
      borderColor = 255;
      return true;
    }
    if (mx < x || mx > x + width || my < y || my > y + height)
    {
      borderColor = 0;
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
 }
