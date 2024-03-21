// Jake Casserly's code for searchBar 20/03/2024

class searchBar extends Widget {
  
  private String result;
  private boolean blank;
  
  public searchBar(float x, float y, float width, float height, String label, color widgetColor, int screenNumber, String result, boolean blank) 
  {
    super(x, y, width, height, label, widgetColor, screenNumber);
    
    this.result = result;
    this.blank = blank;
  }
  
  void adjustText(searchBar theSearchBar) {
    if (theSearchBar.checkMouse(mouseX, mouseY) && blank == false) {
      theSearchBar.label = "";
      blank = true;
    }
    if(keyPressed) {
        label += key;
        //print(key);
    }
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
              print(row.getString("ORIGIN_STATE_ABR"));
            }
            //println(flightnum + " " + (String)result.substring(2));
          }
          println(result.substring(2));
          println("Request fulfilled");
        }
      }
  }
  
}
