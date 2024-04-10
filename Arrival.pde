class Arrival {  
  Data data;
  TableRow row;
  int wac, time,crs; 
  String dest, city, state;
  
  Arrival(Data data,TableRow row)
  {   
    this.data = data;
    this.row = row;
    setData();
  }
  
  int getTime()
  {
    return time;
  }
  
  int getCRS()
  {
    return crs;
  }
  
  String getDest()
  {
    return dest;
  }
  
  String getCity()
  {
    return city;
  }
  
  String getState()
  {
    return state;
  }
  
  int getWAC()
  {
    return wac;
  }
  
  void setData()
  {
    time = row.getInt("ARR_TIME");
    crs = row.getInt("CRS_ARR_TIME");
    dest = row.getString("DEST");
    city = row.getString("DEST_CITY_NAME");
    state = row.getString("DEST_STATE_ABR");
    wac = row.getInt("DEST_WAC");
  }

  String timeFormat(int time)
  {
    int hours = time/100;
    int minutes = time%100;
    String minutesStr;
    if (minutes>=10)
    {
      minutesStr=""+minutes;
    }
    else { minutesStr="0" + minutes;}
    return hours+":"+(minutes == 0 ? "00" :minutesStr);
  }
}
