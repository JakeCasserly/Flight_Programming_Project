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
}



// Rosies suggested changes for Data 20/03
//class Data
//{
//   Table data;
//   TableRow entry;
//   Departure depData;
//   Arrival arrData;
//   String date, code;
//   boolean cancelled, diverted;
//   int distance;
//   int length;
   
//   Data(String database)
//   {
//       data = loadTable(database,"header");
//       length = data.getRowCount();
//       //for (TableRow row:data.getRows())
//       //{
//       //  setData(row);
//       //}
//   }
   
//   Table getData()
//   {
//     return data;
//   }
   
//   void setData(int row)
//   {
//     entry = data.getRow(row);
//     date = split(entry.getString("FL_DATE")," ")[0];
//     code = entry.getString("MKT_CARRIER") + entry.getString("MKT_CARRIER_FL_NUM");
//     depData = new Departure(this,row);
//     arrData = new Arrival(this,row);
//     cancelled = entry.getInt("CANCELLED")==1 ? true : false;
//     diverted = entry.getInt("DIVERTED")==1 ? true : false;
//     distance = entry.getInt("DISTANCE");
//   }
   

//   TableRow getEntry(int row)
//   {
//     entry = data.getRow(row);
//     return entry;
//   }
   
//}
