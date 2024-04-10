/**
 * Jake Casserly's code 02/04/2024
 * I use the "Java How to program late objects - 11th edition - Paul Deitel and Harvey Deitel" book in the Hamilton library to help me with learning concurrency
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
  private volatile boolean running = true;
  private Data database;

  //constructor
  public readDataTask(String taskName) {
    this.taskName = taskName;

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
      // reads Data for a specific flight carrier state by state
      if (taskName == "state") {
        theBarChart.readState();
        terminate();
      }
      else if (taskName == "time") {
        theBarChart.readTime();
        terminate();
      }
      else if (taskName == "PieChart") {
        //thePieChart.angles = thePieChart.percentages();
        thePieChart.percentages();
        terminate();
      }
      else if (taskName == "stateHeat") {
        theHeatMap.readInData();
        terminate();
      }
      else if (taskName == "animateHeatMap") {
        //theHeatMap.drawStates();
        /*
        * Erm... Lets not talk about this... well look...
        * for some reason one thread cannot handle svg styles
        * and colouring in the states. I think theirs some trickery
        * going on within the main thread that can bypass those sorts of errors
        * because by running this code, the program completely combusts.
        */
      }
      else if (taskName == "divertedList") {
        //diverted.drawList();
        terminate();
      }
      else if (taskName == "readAllData!") {
        //flightData = new Data("flights_full.csv");
        flightData.setData();
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
