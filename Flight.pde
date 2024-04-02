class Flight {
  String flightNumber; 
  String origin; 
  String destination; 
  boolean isCancelled;

 
  Flight(String flightNumber, String origin, String destination, boolean isCancelled) {
    this.flightNumber = flightNumber;
    this.origin = origin;
    this.destination = destination;
    this.isCancelled = isCancelled;
  }

  
  
  void display(int x, int y) {
    String flightInfo = flightNumber + ": " + origin + " to " + destination;
    if (isCancelled) {
      flightInfo += " (Cancelled)";
    }
    text(flightInfo, x, y);
  }
}
