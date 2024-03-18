class Departure {  
  int wac; 
  String time, crs, origin, city, state;
  
  Departure(Data data,int row)
  {
    time = timeFormat(data.getEntry(row).getInt("DEP_TIME"));
    crs = timeFormat(data.getEntry(row).getInt("CRS_DEP_TIME"));
    origin = data.getEntry(row).getString("ORIGIN");
    city = data.getEntry(row).getString("ORIGIN_CITY_NAME");
    state = data.getEntry(row).getString("ORIGIN_STATE_ABR");
    wac = data.getEntry(row).getInt("ORIGIN_WAC");
  }

  String timeFormat(int time)
  {
    int hours = time/100;
    int minutes = time%100;
    return hours+":"+(minutes == 0 ? "00" :minutes);
  }
  
}
