// N. Cunningham Added Data class for storing data from csv file 10am 14/03/2024
class Data
{
   Table data;
   TableRow entry;
   int length;
   
   ArrayList<String> date,code;
   ArrayList<Departure> departure;
   ArrayList<Arrival> arrival;
   ArrayList<Boolean> cancelled,diverted;
   ArrayList<Integer> distance;

   Data(String database)
   {
       data = loadTable(database,"header");
       length = data.getRowCount();
       
       date = new ArrayList<String>();
       code = new ArrayList<String>();
       cancelled = new ArrayList<Boolean>();
       diverted = new ArrayList<Boolean>();
       distance = new ArrayList<Integer>();
       
       departure = new ArrayList<Departure>();
       arrival = new ArrayList<Arrival>();
       
       setData();
   }
   
   String getDate(int row)
   {
     return date.get(row);
   }
   
   synchronized String getCode(int row)
   {
     return code.get(row);
   }
   
   Departure getDep(int row)
   {
     return departure.get(row);
   }
   
   Arrival getArr(int row)
   {
     return arrival.get(row);
   }
   
   boolean getCancelled(int row)
   {
     return cancelled.get(row);
   }
   
   boolean getDiverted(int row)
   {
     return diverted.get(row);
   }
   
   int getDistance(int row)
   {
     return distance.get(row);
   }

   synchronized void setData()
   {
       for (TableRow row : data.rows()) 
       {
         date.add(split(row.getString("FL_DATE")," ")[0]);
         code.add(row.getString("MKT_CARRIER") + row.getString("MKT_CARRIER_FL_NUM"));
         cancelled.add(row.getInt("CANCELLED")==1?true:false);
         diverted.add(row.getInt("DIVERTED")==1?true:false);
         distance.add(row.getInt("DISTANCE"));
         departure.add(new Departure(this,row));
         arrival.add(new Arrival(this, row));
       }
   }
   
   // for diverted class
   ArrayList<String[]> getDivertedFlights() {
    ArrayList<String[]> divertedFlights = new ArrayList<String[]>();
    for (int i = 0; i < length; i++) {
        boolean diverted = getDiverted(i);
        if(diverted){
        Departure depData = getDep(i);
        Arrival arrData = getArr(i);
        String flightCode = getCode(i); 
        String date = getDate(i);
        if (diverted) {
            String[] flightInfo = {flightCode, depData.getCity(), arrData.getCity(), arrData.timeFormat(depData.getTime()), date, arrData.getState()};
            divertedFlights.add(flightInfo);
        }
        }
    }
    return divertedFlights;
  }
  
  
  // modified diverted class code for cancelled class
   ArrayList<String[]> getCancelledFlights() {
    ArrayList<String[]> cancelledFlights = new ArrayList<String[]>();
    int numcncld = 0;
    for (int i = 0;(i < length) && (numcncld < 400) ; i++) 
    {
        boolean cancelled = getCancelled(i);
        
        if(cancelled)
        {
          numcncld = numcncld + 1;
          Departure depData = getDep(i);
          Arrival arrData = getArr(i);
          String flightCode = getCode(i); 
          String date = getDate(i);
          if (cancelled) 
          {
              String[] flightInfo = {flightCode, depData.getCity(), arrData.getCity(), arrData.timeFormat(depData.getTime()), date, arrData.getState()};
              cancelledFlights.add(flightInfo);
          }
        }
        
    }
    return cancelledFlights;
  }
}
