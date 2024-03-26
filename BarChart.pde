// barChart
// Jake Casserly's code for Bar Chart 20/03/2024

class barChart {
  int x;
  int y;
  double height;
  double width;
  Data currentData;
  boolean paramatersSame;
  
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
    currentData = new Data("flights_full.csv");
  }
  
  void draw() {
    fill(255);
    strokeWeight(7);
    line(x, y, x, y+750);
    line(x, y+750, x+1000, y+750);
    strokeWeight(3);
    // if x-axis == states (or something of the likes) {
    for (int i = 0; i < allStates.length; i++) {
      line(x+(i*20), y+750, (x-5)+(i*20), y+770);
      textSize(11);
      fill(0);
      text(allStates[i], x+6+(i*20), y+764);
    }
    // }
    
    if (!paramatersSame) {
      readData();
      paramatersSame = true;
    }
    
  }
  
  void readData() {
    
    for (int i = 0; i < currentData.length; i++) {
      currentData.setData(i);
      if (currentData.code.contains("B6")) {
        println(currentData.code.substring(1));
      }
    }
    
  }
  
}
