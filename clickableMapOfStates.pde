import processing.core.PApplet;
import processing.core.PImage;
import processing.data.Table;
import processing.data.TableRow;
import java.util.ArrayList;
import java.util.HashMap;

    ArrayList<Button> stateButtons;
    String selectedState = "";
    PImage mapImage;
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

    public void settings() {
        size(1310, 796);
    }

    public void setup() {
        mapImage = loadImage("Map_of_USA_showing_state_names.png");
        loadAndParseData("flights2k(1).csv");
        initializeButtons();
        backButton = new BackButton("Back", 50, height - 60, 150, 60, true);
    }

    public void draw() {
        background(255);
        image(mapImage, 0, 0, width, height);
        for (Button button : stateButtons) {
            button.display();
        }

        backButton.display();
        if (!selectedState.isEmpty()) {
            drawHistogram(selectedState);
        }
    }

    public void mousePressed() {
        for (Button button : stateButtons) {
            if (button.isOver(mouseX, mouseY)) {
                selectedState = button.label;
                return;
            }
        }
        if (backButton.isOver(mouseX, mouseY)) {
            selectedState = ""; // Reset selected state if back button is pressed
        }
    }

    void loadAndParseData(String fileName) {
        Table table = loadTable(fileName, "header");
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
            println("State not found or no data for state: " + state);
            return;
        }
        

        HashMap<String, Integer> airports = stateAirports.get(state);
        if (airports.isEmpty()) return;

        float margin = 50;
        float spacing = 10;
        float barWidth = (width - 2 * margin - (airports.size() - 1) * spacing) / airports.size();
        float maxFlights = findMaxFlights(airports);

        textSize(20);
        textAlign(CENTER, BOTTOM);
        text("State: " + state, width / 2, margin / 2);

        int i = 0;
        for (String airport : airports.keySet()) {
            float x = margin + i * (barWidth + spacing);
            float flights = airports.get(airport);
            float barHeight = map(flights, 0, maxFlights, 0, height - 2 * margin);

            fill(100, 100, 250);
            noStroke();
            rect(x, height - margin - barHeight, barWidth, barHeight);

            pushMatrix();
            translate(x + barWidth / 2, height - margin + 5);
            rotate(PI / 4);
            fill(0);
            textAlign(LEFT, CENTER);
            text(airport, 0, 0);
            popMatrix();

            i++;
        }

        fill(0);
        textSize(12);
        textAlign(CENTER, BOTTOM);
        text("Airports", width / 2, height - 10);
        textAlign(RIGHT, CENTER);
        text("Number of Flights", margin / 4, height / 2);
    }
    void initializeButtons() {
        // Initialize your buttons based on the `states` and `buttonPositions`
        stateButtons = new ArrayList<Button>();
        for (int i = 0; i < states.length; i++) {
            float x = buttonPositions[i][0];
            float y = buttonPositions[i][1];
            stateButtons.add(new Button(states[i], x, y, 80, 40, false));
        }
    }

    // Inner classes for Button and BackButton (including any logic for displaying and checking if they are clicked
