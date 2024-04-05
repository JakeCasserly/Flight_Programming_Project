/**
 * Jake Casserly's code 02/04/2024
 * I use the "Java: How to program late objects (Java)" book in the Hamilton library to help me with learning concurrency
 * I felt that using mutli-threading would help make the code more efficient when loading in data that has to respond to user input.
 * The code that I have here is a class called readDataTask that implements the Runnable class which is built into java.
 * Using the runnable class I can instantiate threads which can do specific tasks whilst keeping the main thread free.
 * Keeping the main thread free will allow the main thread to draw the objects to the screen whilst data is being
 * read in in the background.
 */

//import java.security.SecureRandom;

public class readDataTask implements Runnable {
  //private final SecureRandom generator = new SecureRandom();
  //private final int sleepTime; // random sleep time for thread if we want the thread to sleep
  private final String taskName;
  private String request;
  private volatile boolean running = true;
  private Data database;
  private int number;

  //constructor
  public readDataTask(String taskName, String request, Data database) {
    this.taskName = taskName;
    this.request = request;
    this.database = database;
    number = 0;

    //sleepTime = generator.nextInt(5000); // pick random sleep time between 0 and 5 seconds
  }

  /** depending on method, may need keyword "synchronized"
   * (ONLY if updating a shared array (such as flights from Austin etc)),
   * this wont be needed if shared arrays among threads are only modified by the main thread
   */

  @Override
  public void run() {
    while (running) {
      //try {
      String[] date;
      // reads Data for a specific flight carrier state by state
      if (taskName == "state") {
        for (int i = 0; i < database.length; i++) {
          database.setData(i);
          if (database.code.contains(request)) {
            for (int z = 0; z < theBarChart.allStates.length; z++) {
              if (theBarChart.departures) {
                theBarChart.state = database.depData.state;
              }
              else {
                theBarChart.state = database.arrData.state;
              }
              if (theBarChart.state.equals(theBarChart.allStates[z])) {
                number = theBarChart.amountInStates.get(z);
                theBarChart.amountInStates.set(z, number+1);
                //print(z);

              }
            }
            theBarChart.count++;
            //print(theBarChart.count + " ");
          }
          //print("test");
        }
        //theBarChart.dataRead = true;
        terminate();
      }
      else if (taskName == "time") {
        for (int i = 0; i < database.length; i++) {
          database.setData(i);
          //if (currentData.code.contains(flightCarrier)) {        // possiblility to restrict it to specific flight carriers
          date = database.date.split("/");
          //print(date[1]); testing
          for (int z = 0; z < theBarChart.dates.length; z++) {
            if (Integer.parseInt(date[1]) == theBarChart.dates[z]) {
              number = theBarChart.amountOnDate.get(z);
              theBarChart.amountOnDate.set(z, number+1);
            }
          }
          theBarChart.countTime++;
          //}
        }
        theBarChart.readTime = true;
        terminate();
      }
      else if (taskName == "PieChart") {
        thePieChart.angles = thePieChart.percentages();
        terminate();
      }
      else {
        // do nothing forever
      }
      
      //}
      //catch (InterruptedException exception) {
      //  exception.printStackTrace();
      //  Thread.currentThread().interrupt(); // re-interrupt the thread
      //}

      // print task name
      System.out.printf("%s done reading the data%n", taskName);
    }
  }

  public void terminate() {
    running = false;
  }
  
  public void setRunning() {
    running = true;
  }
}
