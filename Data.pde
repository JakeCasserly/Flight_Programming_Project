// N. Cunningham Added Data class for storing data from csv file 10am 14/03/2024
class Data
{
   Table data;
   TableRow entry;
   String date, code;
   
   Data(String database)
   {
       data = loadTable(database,"header");
   }
   
   Table getData()
   {
     return data;
   }

   TableRow getEntry(int row)
   {
     date = split(row.getString("FL_DATE")," ")[0];
     code = row.getString("MKT_CARRIER") + row.getString("MKT_CARRIER_FL_NUM");
     Departure(row);
     return data.getRow(row);
   }
   
   
   
   //void searchData(String info)
   //{
   //  for (TableRow row:data.rows())
   //  {
   //    date = split(row.getString("FL_DATE")," ")[0];
   //    code = row.getString("MKT_CARRIER") + row.getString("MKT_CARRIER_FL_NUM");
   //    // DEPARTURE DATA
   //    Departure(row);
   //    // ARRIVAL DATA
   //  }
   //}
   
