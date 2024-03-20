// arrivals
class Arrivals {  
  int oriWac, destWac; 
  String time, crs, origin, oriCity, oriState, dest, destCity, destState;
  
  Arrivals(Data data,int row)
  {
    time = timeFormat(data.getEntry(row).getInt("DEP_TIME"));
    crs = timeFormat(data.getEntry(row).getInt("CRS_DEP_TIME"));
    origin = data.getEntry(row).getString("ORIGIN");
    oriCity = data.getEntry(row).getString("ORIGIN_CITY_NAME");
    oriState = data.getEntry(row).getString("ORIGIN_STATE_ABR");
    oriWac = data.getEntry(row).getInt("ORIGIN_WAC");
    dest = data.getEntry(row).getString("DEST");
    destCity = data.getEntry(row).getString("DEST_CITY_NAME");
    destState = data.getEntry(row).getString("DEST_STATE_ABR");
    destWac = data.getEntry(row).getInt("DEST_WAC");
  }

  String timeFormat(int time)
  {
    int hours = time/100;
    int minutes = time%100;
    return hours+":"+(minutes == 0 ? "00" :minutes);
  }
  
}
