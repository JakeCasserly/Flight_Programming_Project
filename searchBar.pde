// Jake Casserly's code for searchBar 20/03/2024

class searchBar {
  
  float x, y, width, height;
  String label;
  color widgetColor, labelColor, borderColor;
  private boolean active;
  private String result;
  private boolean blank;
  
  public searchBar(float x, float y, float width, float height, String label, color widgetColor, String result, boolean blank) 
  {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.label = label;
    this.widgetColor = widgetColor;
    labelColor = color(0);
    this.result = result;
    this.blank = false;
  }
  
  void display() 
  {
    strokeWeight(5);
    stroke(borderColor);
    fill(widgetColor);
    rect(x, y, width, height, 15);
    fill(labelColor);
    textAlign(CENTER, CENTER);
    textSize(25);
    text(label, x + width / 2, y + height / 2);
  }
  
  void adjustText() 
  {
      if (!blank) 
      {
        label = "";
        blank = true;
      }
      if (keyPressed) 
      {
        if (key != ENTER && key != BACKSPACE) 
        {
          label += key;
        } 
        else if (key == BACKSPACE && label.length() > 0) 
        {
          label = label.substring(0, label.length() - 1);
        }
        keyPressed = false;
      }
  }
  
  boolean checkSearchBar(float mx, float my)
  {
    if (mx > x && mx < x + width && my > y && my < y + height)
    {
      return true;
    }
    return false;
  }
  
  boolean checkBorder(float mx, float my)
  {
    if (mx > x && mx < x + width && my > y && my < y + height)
    {
      borderColor = 255;
      return true;
    }
    if (mx < x || mx > x + width || my < y || my > y + height)
    {
      borderColor = 0;
      return true;
    }
    return false;
  }
  
  void result() {
     String test = label;
     println("Request");
      if (label != "type text here...") {
        result = test.toUpperCase();
        println("Request fulfilled");
      }
      else {
        label = "";
        print("reset");
      }
  }
 }
