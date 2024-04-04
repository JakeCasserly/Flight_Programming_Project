// cancelled Flight

class CancelledFlights {
  
  int cancld;
  ArrayList<ArrayList<String>> cancelledArrayList = new ArrayList<>();
  int numCncld = 0;
  int arrayRow = 0;
  String date, carrier, carrierFlNum, origin, originCity, originState, originWAC, dest, destCity, destState, destWAC, crsDepTime, crsArrTime, dist;
  
  
  CancelledFlights (Data data)
  {
    
    int row = 1;
    
    while ( row <= data.length)
    {
        cancld = data.getEntry(row).getInt("CANCELLED");
        if(cancld == 1)
        {
          
          numCncld = numCncld + 1;
          
          date = data.getEntry(row).getString("FL_DATE");
          carrier = data.getEntry(row).getString("MKT_CARRIER");
          carrierFlNum = data.getEntry(row).getString("MKT_CARRIER_FL_NUM");
          origin = data.getEntry(row).getString("ORIGIN");
          originCity = data.getEntry(row).getString("ORIGIN_CITY_NAME");
          originState = data.getEntry(row).getString("ORIGIN_STATE_ABR");
          originWAC = data.getEntry(row).getString("FL_DATE");
          dest = data.getEntry(row).getString("DEST");
          destCity = data.getEntry(row).getString("DEST_CITY");
          destState = data.getEntry(row).getString("DEST_STATE_ABR");
          destWAC = data.getEntry(row).getString("DEST_WAC");
          crsDepTime = timeFormat(data.getEntry(row).getInt("CRS_DEP_TIME"));
          crsArrTime = timeFormat(data.getEntry(row).getInt("CRS_ARR_TIME"));
          dist = data.getEntry(row).getString("DISTANCE");
          
          cancelledArrayList.add(new ArrayList<>());
          
          cancelledArrayList.get(arrayRow).add(date);
          cancelledArrayList.get(arrayRow).add(carrier);
          cancelledArrayList.get(arrayRow).add(carrierFlNum);
          cancelledArrayList.get(arrayRow).add(origin);
          cancelledArrayList.get(arrayRow).add(originCity);
          cancelledArrayList.get(arrayRow).add(originState);
          cancelledArrayList.get(arrayRow).add(originWAC);
          cancelledArrayList.get(arrayRow).add(dest);
          cancelledArrayList.get(arrayRow).add(destCity);
          cancelledArrayList.get(arrayRow).add(destState);
          cancelledArrayList.get(arrayRow).add(destWAC);
          cancelledArrayList.get(arrayRow).add(crsDepTime);
          cancelledArrayList.get(arrayRow).add(crsArrTime);
          cancelledArrayList.get(arrayRow).add(dist);
          
          arrayRow = arrayRow + 1;
          
          
        }
        
        row = row + 1;
    }
    
  }
  
  String timeFormat(int time)
  {
    int hours = time/100;
    int minutes = time%100;
    return hours+":"+(minutes == 0 ? "00" :minutes);
  }
  
  
  
}
