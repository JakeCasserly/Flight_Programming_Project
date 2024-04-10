/*import processing.core.PApplet;
import processing.core.PImage;
import processing.data.Table;
import processing.data.TableRow;
import java.util.ArrayList;
import java.util.HashMap;

class clickableMap  {
  PApplet p;
    ArrayList<Button> stateButtons;
    String selectedState = "";
    PImage mapImage;
     String databasePath;
    HashMap<String, HashMap<String, Integer>> stateAirports = new HashMap<>();
    String[] states = {"WA", "ID", "MT", "ND", "MN", "IL", "MI", "NY", "VT", "NH", "ME",
    "OR", "NV", "WY", "SD", "IA", "IN", "OH", "PA", "NJ", "CT", "RI", "MA",
    "CA", "UT", "CO", "NE", "MO", "KY", "WV", "VA", "MD", "DE",
    "AZ", "NM", "KS", "AR", "TN", "NC", "SC", "WI",
    "OK", "LA", "MS", "AL", "GA", "FL",
    "TX", "AK", "HI"};
  float[][] buttonPositions = {
    {145, 88}, {244, 223}, {355, 147}, {539, 141}, {642, 168}, {762, 343}, {857, 252}, {1034, 236}, {1006, 92},
    {991, 52}, {1164, 126}, {111, 187}, {162, 333}, {379, 259}, {534, 225}, {671, 295}, {831, 343}, {916, 324},
    {1015, 286}, {1219, 333}, {1242, 299}, {1232, 267}, {979, 122}, {96, 415}, {267, 343}, {395, 370}, {532, 303},
    {701, 392}, {857, 417}, {1232, 436}, {1017, 402}, {1242, 402}, {1246, 364}, {252, 482}, {393, 497}, {560, 389},
    {692, 488}, {850, 465}, {1002, 455}, {987, 497}, {751, 202}, {593, 476}, {737, 626}, {770, 556}, {840, 528},
    {945, 547}, {1006, 691}, {549, 594}, {145, 663}, {364, 750}};
    BackButton backButton;
    
   public clickableMap(PApplet p, int x, int y, double width, double height, String database) {
        this.p = p;
        this.databasePath = database; 
        
        this.mapImage = p.loadImage("Map_of_USA_showing_state_names.png");
        
        loadAndParseData(databasePath); 
        initializeButtons(x, y, width, height);
        backButton = new BackButton(p, "Back", p.width - 160, p.height - 80, 150, 60, true);
    }
    
     void initializeButtons(int x, int y, double width, double height) {
       
        for (int i = 0; i < states.length; i++) {
           
            stateButtons.add(new Button(p, states[i], buttonPositions[i][0], buttonPositions[i][1], 80, 40, false));
        }
    }

    public void settings() {
        size(1310, 796);
    }

    public void setup() {
        mapImage = loadImage("Map_of_USA_showing_state_names.png");
        loadAndParseData("flights2k(1).csv");
        initializeButtons(0, 0, p.width, p.height); 
        backButton = new BackButton(p, "Back", 50, p.height - 60, 150, 60, true);
    }

     public void draw() {
        p.background(255);
        p.image(mapImage, 0, 0, p.width, p.height);
        for (Button button : stateButtons) {
            button.display();
        }
        backButton.display();
        if (!selectedState.isEmpty()) {
            drawHistogram(selectedState);
        }
    }

    //public void mousePressed() {
    //    for (Button button : stateButtons) {
    //        if (button.isOver(mouseX, mouseY)) {
    //            selectedState = button.label;
    //            return;
    //        }
    //    }
    //    if (backButton.isOver(mouseX, mouseY)) {
    //        selectedState = ""; // Reset selected state if back button is pressed
    //    }
    //}

    void loadAndParseData(String fileName) {
        Table table = p.loadTable(fileName, "header");
        for (TableRow row : table.rows()) {
            String state = row.getString("ORIGIN_STATE_ABR");
            String airport = row.getString("ORIGIN");
            stateAirports.computeIfAbsent(state, k -> new HashMap<>()).merge(airport, 1, Integer::sum);
        }
    }int findMaxFlights(HashMap<String, Integer> airports) {
    int maxFlights = 0;
    for (Integer flights : airports.values()) {
      if (flights > maxFlights) {
        maxFlights = flights;
      }
    }
    return maxFlights;
  }

   void drawHistogram(String state) {
    if (!stateAirports.containsKey(state)) {
        p.println("State not found or no data for state: " + state); // Use p.println
        return;
    }

    HashMap<String, Integer> airports = stateAirports.get(state);
    if (airports.isEmpty()) return;

    float margin = 50;
    float spacing = 10;
    // Note: use p.width and p.height to access the dimensions of the sketch
    float barWidth = (p.width - 2 * margin - (airports.size() - 1) * spacing) / airports.size();
    float maxFlights = findMaxFlights(airports);

    p.textSize(20);
    p.textAlign(PApplet.CENTER, PApplet.BOTTOM);
    p.text("State: " + state, p.width / 2, margin / 2);

    int i = 0;
    for (String airport : airports.keySet()) {
        float x = margin + i * (barWidth + spacing);
        float flights = airports.get(airport);
        float barHeight = p.map(flights, 0, maxFlights, 0, p.height - 2 * margin);

        p.fill(100, 100, 250);
        p.noStroke();
        p.rect(x, p.height - margin - barHeight, barWidth, barHeight);

        p.pushMatrix();
        p.translate(x + barWidth / 2, p.height - margin + 5);
        p.rotate(PApplet.PI / 4);
        p.fill(0);
        p.textAlign(PApplet.LEFT, PApplet.CENTER);
        p.text(airport, 0, 0);
        p.popMatrix();

        i++;
    }

    p.fill(0);
    p.textSize(12);
    p.textAlign(PApplet.CENTER, PApplet.BOTTOM);
    p.text("Airports", p.width / 2, p.height - 10);
    p.textAlign(PApplet.RIGHT, PApplet.CENTER);
    p.text("Number of Flights", margin / 4, p.height / 2);
   }
}
*/
