// N. Cunningham Added Data class for storing data from csv file 10am 14/03/2024
class Data
{
   Table data;
   TableRow entry;
   // variables of each flight entry
   Departure depData;
   Arrivals arrData;
   String date, code;
   boolean cancelled, diverted;
   int distance;
   int length;
   
   // parameter string is csv file name
   Data(String database)
   {
       data = loadTable(database,"header");
       length = data.getRowCount();
       //for (TableRow row:data.getRows())
       //{
       //  setData(row);
       //}
   }
   
   // return full table of data
   Table getData()
   {
     return data;
   }
   
   // sets variables for row 
   
   /* To search through database, use for loop in main with some
   counter variable i. For each loop MUST use setData(i) to set
   the variables of that row. 
   
   Then access variables e.g. 
   data.cancelled == TRUE ? or average += data.distance
   
   Access depData and arrData: 
   e.g. data.depData.time for departure time
   e.g. data.arrData.city for destination city
   */
   
   void setData(int row)
   {
     entry = data.getRow(row);
     // take first index of date & disregard time
     date = split(entry.getString("FL_DATE")," ")[0];
     code = entry.getString("MKT_CARRIER") + entry.getString("MKT_CARRIER_FL_NUM");
     // depData holds variables for departure e.g. time, origin
     depData = new Departure(this,row);
     // arrData holds variable for arrival e.g. time, destination
     arrData = new Arrivals(this,row);
     // check if cancelled / diverted
     cancelled = entry.getInt("CANCELLED")==1 ? true : false;
     diverted = entry.getInt("DIVERTED")==1 ? true : false;
     distance = entry.getInt("DISTANCE");
   }
   
   // return row from databas
   TableRow getEntry(int row)
   {
     entry = data.getRow(row);
     return entry;
   }
}
