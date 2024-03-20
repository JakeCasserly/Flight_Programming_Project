ArrayList<Button> stateButtons;
PImage mapImage;
String selectedState = "";
boolean showCancelledFlights = false;
boolean showStateDetails = false;
boolean displayHistogram = false;

HashMap<String, ArrayList<Flight>> flightsByState = new HashMap<String, ArrayList<Flight>>();
String[] states = {"WA", "ID", "MT", "ND", "MN", "IL", "MI", "NY", "VT", "NH", "ME",
  "OR", "NV", "WY", "SD", "IA", "IN", "OH", "PA", "NJ", "CT", "RI", "MA",
  "CA", "UT", "CO", "NE", "MO", "KY", "WV", "VA", "MD", "DE",
  "AZ", "NM", "KS", "AR", "TN", "NC", "SC", "WI",
  "OK", "LA", "MS", "AL", "GA", "FL",
  "TX", "AK", "HI"};
float[][] buttonPositions = { {145, 88}, {244, 223}, {355, 147}, {539, 141}, {642, 168}, {762, 343}, {857, 252}, {1034, 236}, {1006, 92},
  {991, 52}, {1164, 126}, {111, 187}, {162, 333}, {379, 259}, {534, 225}, {671, 295}, {831, 343}, {916, 324},
  {1015, 286}, {1219, 333}, {1242, 299}, {1232, 267}, {979, 122}, {96, 415}, {267, 343}, {395, 370}, {532, 303},
  {701, 392}, {857, 417}, {1232, 436}, {1017, 402}, {1242, 402}, {1246, 364}, {252, 482}, {393, 497}, {560, 389},
  {692, 488}, {850, 465}, {1002, 455}, {987, 497}, {751, 202}, {593, 476}, {737, 626}, {770, 556}, {840, 528},
  {945, 547}, {1006, 691}, {549, 594}, {145, 663}, {364, 750}};



BackButton backButton;

void setup() {
  size(1310, 796);
  stateButtons = new ArrayList<Button>();
  mapImage = loadImage("Map_of_USA_showing_state_names.png");
 
  for (int i = 0; i < states.length; i++) {
    float x = buttonPositions[i][0];
    float y = buttonPositions[i][1];
    
    stateButtons.add(new Button(states[i], x, y, 80, 40, false));
  }

  
  backButton = new BackButton("Back", 50, height - 60, 150, 60, true, color(200), color(255)); // Make the "Back" button bigger and label visible
}


void draw() {
  textSize(12);
  background(255);
  boolean isCursorOverButton = false;
  displayHistogram = false;
  if (!showStateDetails) {
    image(mapImage, 0, 0, width, height); 
    for (Button button : stateButtons) {
      button.display(); 
      if (button.isOver(mouseX, mouseY)) {
        isCursorOverButton = true; 
      }
    }
  } else {
    if (displayHistogram) {
      
      background(240);
      textSize(24);
      text("Flights from " + selectedState, 100, 50); // Title for histogram

      flightManager.stateInput = selectedState;
      
      flightManager.displayHistogram(selectedState);
    } else {
     
      textSize(32); // Larger text for detailed view
      text("Details for " + selectedState, 100, 100);
    }


    backButton.display();
    if (backButton.isOver(mouseX, mouseY)) {
      isCursorOverButton = true;
    }
  }


  if (isCursorOverButton) {
    cursor(HAND); 
  } else {
    cursor(ARROW); 
  }
}


void drawStateDetailsScreen() {
  background(240);
  if (displayHistogram) {
    textSize(24);
    text("Flights from " + selectedState, 100, 50); // Title for histogram
  } else {
    // Display other state details if not showing histogram
    textSize(32);
    text("Details for " + selectedState, 100, 100);
  }
  backButton.display();
}



void mousePressed() {
  if (showStateDetails) {
    if (backButton.isOver(mouseX, mouseY)) {
      showStateDetails = false; 
      displayHistogram = false;
    }
  } else {
    for (Button button : stateButtons) {
      if (button.isOver(mouseX, mouseY)) {
        selectedState = button.label;
        showStateDetails = true;
        displayHistogram = true; 
        break;
      }
    }
  }
}
