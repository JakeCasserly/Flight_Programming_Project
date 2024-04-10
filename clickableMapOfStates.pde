/*
import processing.core.PApplet;
import processing.core.PImage;
import processing.data.Table;
import processing.data.TableRow;
import java.util.ArrayList;
import java.util.HashMap;

public class clickableMapOfStates {
    PApplet p;
    ArrayList<Button> stateButtons = new ArrayList<>();
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
    {167.36, 108.56}, {281.62, 275.11}, {409.74, 181.35}, {622.11, 173.95}, {741.00, 207.26},
{879.50, 423.15}, {989.15, 310.88}, {1193.44, 291.15}, {1161.12, 113.50}, {1143.81, 64.15},
{1343.49, 155.44}, {128.12, 230.70}, {187.98, 410.81}, {437.44, 319.52}, {616.34, 277.58},
{774.47, 363.93}, {959.14, 423.15}, {1057.25, 399.71}, {1171.51, 352.83}, {1406.97, 410.81},
{1433.51, 368.87}, {1421.97, 329.39}, {1130.00, 150.51}, {110.80, 511.97}, {308.17, 423.15},
{455.91, 456.46}, {614.03, 373.80}, {809.09, 483.60}, {989.15, 514.44}, {1421.97, 537.88},
{1173.82, 495.93}, {1433.51, 495.93}, {1438.13, 449.06}, {290.86, 594.63}, {453.60, 613.13},
{646.35, 479.90}, {798.71, 602.03}, {981.07, 573.66}, {1156.51, 561.32}, {1139.19, 613.13},
{866.80, 249.20}, {684.44, 587.23}, {850.64, 772.28}, {888.73, 685.92}, {969.53, 651.38},
{1090.72, 674.82}, {1161.12, 852.46}, {633.65, 732.80}, {167.36, 817.92}, {420.13, 925.25}};

    BackButton backButton;
    String databasePath;
    
    int x, y;
    double width, height;

    public clickableMapOfStates(PApplet p, int x, int y, double width, double height, String database) {
        this.p = p;
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.databasePath = database;
        this.mapImage = p.loadImage("Map_of_USA_showing_state_names.png");

        loadAndParseData(databasePath);
        initializeButtons();
        backButton = new BackButton(p, "Back", p.width - 160, p.height - 80, 150, 60, true);
    }
    void initializeButtons() {
    stateButtons.clear(); // Clear existing buttons if any.
    for (int i = 0; i < states.length; i++) {
        float x = buttonPositions[i][0];
        float y = buttonPositions[i][1];
        // Adding 'true' as the last parameter to denote that the button is active by default
        stateButtons.add(new Button(p, states[i], x, y, 80, 40, true)); 
    }
}

    
    


    public void settings() {
        size(1310, 796);
    }

    public void setup() {
        mapImage = loadImage("Map_of_USA_showing_state_names.png");
        loadAndParseData("flights2k(1).csv");
        initializeButtons(); 
        backButton = new BackButton(p, "Back", 50, p.height - 60, 150, 60, true);
    }

    public void draw() {
    p.background(255);
    p.image(mapImage, 0, 0, p.width, p.height);
    
    boolean isCursorOverButton = false;
    for (Button button : stateButtons) {
        button.display();
        if (button.isOver(p.mouseX, p.mouseY)) {
            isCursorOverButton = true;
            break; // Exit the loop early if one is found
        }
    }
    
    // Change cursor based on whether it is over a button
    if (isCursorOverButton) {
        p.cursor(PApplet.HAND);
    } else {
        p.cursor(PApplet.ARROW);
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
    HashMap<String, Integer> airports = stateAirports.get(state);
    if (airports.isEmpty()) return;

    float margin = 50;
    float spacing = 10;
    
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
