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
   
   String getCode(int row)
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

   void setData()
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
}
