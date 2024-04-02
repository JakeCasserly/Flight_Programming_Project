import java.util.HashMap;
import processing.data.Table;
import processing.data.TableRow;

HashMap<String, HashMap<String, Integer>> stateAirports;
String currentState = "";

void setup() {
  size(1310, 500);
  stateAirports = new HashMap<String, HashMap<String, Integer>>();
  loadAndParseData("flights2k(1).csv");
}

void draw() {
  background(255);
  if (!currentState.isEmpty()) {
    drawHistogram(currentState);
  }
}

void keyPressed() {
  if (key >= 'A' && key <= 'Z') {
    currentState += key;
    if (currentState.length() > 2) {
      currentState = "";
    }
  } else if (key == BACKSPACE && currentState.length() > 0) {
    currentState = currentState.substring(0, currentState.length() - 1);
  } else if (key == ENTER || key == RETURN) {
    drawHistogram(currentState);
  }
}

void loadAndParseData(String fileName) {
  Table table = loadTable(fileName, "header");
  for (TableRow row : table.rows()) {
    String state = row.getString("ORIGIN_STATE_ABR");
    String airport = row.getString("ORIGIN");
    if (!stateAirports.containsKey(state)) {
      stateAirports.put(state, new HashMap<String, Integer>());
    }
    HashMap<String, Integer> airports = stateAirports.get(state);
    if (!airports.containsKey(airport)) {
      airports.put(airport, 1);
    } else {
      airports.put(airport, airports.get(airport) + 1);
    }
  }
}

int findMaxFlights(HashMap<String, Integer> airports) {
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
  int numAirports = airports.size();
  if (numAirports == 0) return;

  float margin = 50;
  float spacing = 10;
  float barWidth = (width - 2 * margin - (numAirports - 1) * spacing) / numAirports;
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
