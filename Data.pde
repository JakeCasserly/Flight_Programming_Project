// N. Cunningham Added Data class for storing data from csv file 10am 14/03/2024
class Data
{
   Table data;
   TableRow entry;
   Departure depData;
   String date, code;
   boolean cancelled, diverted;
   int distance;
   int length;
   
   Data(String database)
   {
       data = loadTable(database,"header");
       length = data.getRowCount();
       //for (TableRow row:data.getRows())
       //{
       //  setData(row);
       //}
   }
   
   Table getData()
   {
     return data;
   }
   
   void setData(int row)
   {
     entry = data.getRow(row);
     date = split(entry.getString("FL_DATE")," ")[0];
     code = entry.getString("MKT_CARRIER") + entry.getString("MKT_CARRIER_FL_NUM");
     depData = new Departure(this,row);
     //arrData = new Arrival(data,row);
     cancelled = entry.getInt("CANCELLED")==1 ? true : false;
     diverted = entry.getInt("DIVERTED")==1 ? true : false;
     distance = entry.getInt("DISTANCE");
   }
   

   TableRow getEntry(int row)
   {
     entry = data.getRow(row);
     return entry;
   }
   
}
