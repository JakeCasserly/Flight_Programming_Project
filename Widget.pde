class Widget 
{
  float x, y, width, height;
  String label;
  color widgetColor, labelColor, borderColor, screenNumber;
  
  Widget(float x, float y, float width, float height, String label, color widgetColor, int screenNumber) 
  {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.label = label;
    this.widgetColor = widgetColor;
    this.screenNumber = screenNumber;
    labelColor = color(0);
  }
  
  void display() 
  {
    strokeWeight(5);
    stroke(borderColor);
    fill(widgetColor);
    rect(x, y, width, height, 15);
    fill(labelColor);
    textAlign(CENTER, CENTER);
    text(label, x + width / 2, y + height / 2);
    textSize(50);
  }
  
  void display1() 
  {
    strokeWeight(5);
    stroke(borderColor);
    fill(widgetColor);
    rect(x, y, width, height, 15, 15, 0, 0);
    fill(labelColor);
    textAlign(CENTER, CENTER);
    text(label, x + width / 2, y + height / 2);
    textSize(50);
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
  
  boolean checkMouse(float mx, float my) {
    if (mx > x && mx < x + width && my > y && my < y + height) 
    {
      count = screenNumber;
      return true;
    }
    return false;
  }
}
