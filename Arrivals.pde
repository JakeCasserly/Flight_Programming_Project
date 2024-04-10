/*// arrivals
class Arrivals {  
  int wac; 
  String time, crs, city, state, dest;
  
  Arrivals(Data data,int row)
  {
    time = timeFormat(data.getEntry(row).getInt("ARR_TIME"));
    crs = timeFormat(data.getEntry(row).getInt("CRS_ARR_TIME"));
    dest = data.getEntry(row).getString("DEST");
    city = data.getEntry(row).getString("DEST_CITY_NAME");
    state = data.getEntry(row).getString("DEST_STATE_ABR");
    wac = data.getEntry(row).getInt("DEST_WAC");
  }

  String timeFormat(int time)
  {
    int hours = time/100;
    int minutes = time%100;
    return hours+":"+(minutes == 0 ? "00" :minutes);
  }
  
}
*/
