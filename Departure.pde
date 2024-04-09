class Departure {  
  Data data;
  TableRow row;
  int wac, time,crs; 
  String origin, city, state;
  
  Departure(Data data,TableRow row)
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
  
  String getOrigin()
  {
    return origin;
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
    time = row.getInt("DEP_TIME");
    crs = row.getInt("CRS_DEP_TIME");
    origin = row.getString("ORIGIN");
    city = row.getString("ORIGIN_CITY_NAME");
    state = row.getString("ORIGIN_STATE_ABR");
    wac = row.getInt("ORIGIN_WAC");
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
